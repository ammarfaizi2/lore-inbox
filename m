Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWAXHQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWAXHQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 02:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAXHQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 02:16:34 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:47607 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932239AbWAXHQe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 02:16:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTa5u3uTgbvRmeXP4SNjdESQhFi8MXvAVqfWR6YfTiGM0nSIIaeyDYGsXxQSuTnREbbaGdPLil8oc7cLpbTSi/mh+M0XFln9M4HXu033DZUhea4qkPtwnezaLoOCVonp2lE22l+o5Stigx6DRjHvk0S1e8A1/THmyT8jyGD02xw=
Message-ID: <81b0412b0601232316h6a26b083oab0b6d8de15e4c95@mail.gmail.com>
Date: Tue, 24 Jan 2006 08:16:31 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: How to discover new Linux features (was: Re: Linux 2.6.16-rc1)
Cc: Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200601182323_MC3-1-B627-7710@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601182323_MC3-1-B627-7710@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
>  Say you are comparing kernels 2.6.14 and 2.6.15, trying to see what
> is new.  Just do this:
>
>  1.  Copy a .config file into your 2.6.14 directory.
>
>  2.  Run "make oldconfig" there.  It doesn't really matter what
>      answers you give so long as it runs to completion.

make it "make allconfig"
