Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVHZUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVHZUJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVHZUJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:09:42 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:5190 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030252AbVHZUJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:09:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LuECe12ccpKThNBxtFiiayvVvHf2Q+jtOoQQf4rWWTbYu71iZ3LUVUVLyQYr15NwPC/+YITB+95bCpp/+k6jc0e1zDGa+soEpNdnvzt+lAqTMcoUCTkyRpAvLhWtg4ay0E834itwdi6qhqgZJdspBpJn9bfqxHEoVfTS05SUNeo=
Message-ID: <d120d50005082613094cd2f596@mail.gmail.com>
Date: Fri, 26 Aug 2005 15:09:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Robert Love <rml@novell.com>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1125085429.18155.99.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125069494.18155.27.camel@betsy>
	 <d120d500050826122768cd3612@mail.gmail.com>
	 <1125085141.18155.97.camel@betsy> <1125085429.18155.99.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Robert Love <rml@novell.com> wrote:
> On Fri, 2005-08-26 at 15:39 -0400, Robert Love wrote:
> 
> > > This is racy - 2 threads can try to do this simultaneously.
> >
> > Fixed.  Thanks.
> 
> Actually, doesn't sysfs and/or the vfs layer serialize the two
> simultaneous writes?
> 

Not between 2 separate processes (or, rather, separate file handles)
as far as I can see...

-- 
Dmitry
