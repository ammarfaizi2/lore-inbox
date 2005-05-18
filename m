Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVERKmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVERKmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVERKmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:42:47 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:22000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262165AbVERKmf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EBe1Vv3cfb3WF0db85wTqnFUCrgvq42M9yeZQgqqRIwoe8lB5VC1alnwHaAoOiLZTQbLJC6TaqXQfOzlrntkeE1p9s552edwnCKp5H6hXSrfK5YmQCJlyCILaV+FYCR20CHIF9VrEbTferqb1m0a+qe88NSmbe/ejwfZCgJ9i9U=
Message-ID: <2cd57c900505180342281248f4@mail.gmail.com>
Date: Wed, 18 May 2005 18:42:33 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6 jiffies
Cc: linux <kernel@wired-net.gr>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1116412348.6572.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1116005355.6248.372.camel@localhost>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <001b01c55b92$1d09c6e0$0101010a@dioxide>
	 <1116411888.6572.18.camel@laptopd505.fenrus.org>
	 <004601c55b94$5ea29d50$0101010a@dioxide>
	 <1116412348.6572.21.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2005-05-18 at 13:28 +0300, linux wrote:
> > ok.i see what u mean.
> > But should this value on a stable version be 0 again???
> 
> why?
> "the absolute value has no meaning" -> why would "0" be special ???
> Answer: It's not. And actually -5 minutes is more useful than 0 because
> it keeps helping finding bugs... why do you want it to start at 0 ?
> 


The negative value doesn't hurt. It's unsigned. Maybe he was thinking
reading jiffies as the  uptime directly.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
