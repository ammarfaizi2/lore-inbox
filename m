Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVKAU5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVKAU5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVKAU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:57:48 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:61289 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbVKAU5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:57:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rFwSF8zTgbSnh+EsE+XWu4496SUFvOi6lWczflFXrtgC7tQntq+KFWQlFG7V6hf0oSz5y1jiBLz7N3zf9b4Gl718wRZLviclJlYBaxynE+1yTXv/Ia/c9MxUEWUaOnUg0WAO+8vhDTOiupTSBVY4NFW5QVbubcwBt5kLxVUkBk8=
Message-ID: <5449aac20511011257n6b081b5qa20af928a2f9e98f@mail.gmail.com>
Date: Tue, 1 Nov 2005 20:57:46 +0000
From: Alexander Fisher <alexjfisher@gmail.com>
Reply-To: alex@alexfisher.me.uk
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Would I be violating the GPL?
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130875080.22089.14.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
	 <200511012000.21176.mbuesch@freenet.de>
	 <1130875080.22089.14.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-11-01 at 20:00 +0100, Michael Buesch wrote:
> > On Tuesday 01 November 2005 18:49, Alexander Fisher wrote:
> > > Hello.
> > >
> > > A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
> > > driver as source code.  They have provided this code source with a
> > > license stating I won't redistribute it in anyway.
> > > My concern is that if I build this code into a module, I won't be able
> > > to distribute it to customers without violating either the GPL (by not
> > > distributing the source code), or the proprietary source code license
> > > as currently imposed by the supplier.
> > > From what I have read, this concern is only valid if the binary module
> > > is considered to be a 'derived work' of the kernel.  The module source
> > > directly includes the following kernel headers :
> >
> > Take the code and write a specification for the device.
> > Should be fairly easy.
> > Someone else will pick up the spec and write a clean GPLed driver.
>
> Seems excessive, why not just use a kernel debugger to capture all PIO
> traffic to the device and write a driver based on that?

Interesting, I hadn't thought of that.  Alternatively, if I really
wanted to upset them (which I don't), I could use one of the very
expensive PCI bus analysers we've bought off them in the past!

Alex
