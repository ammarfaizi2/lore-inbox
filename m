Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRJJWvw>; Wed, 10 Oct 2001 18:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274265AbRJJWvn>; Wed, 10 Oct 2001 18:51:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:28922
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274260AbRJJWvi>; Wed, 10 Oct 2001 18:51:38 -0400
Date: Wed, 10 Oct 2001 15:52:03 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Compile Filure on 2.4.10-ac10+preempt+smp
Message-ID: <20011010155203.A3795@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com> <1002690949.862.233.camel@phantasy> <20011009222403.A12825@mikef-linux.matchmail.com> <1002692093.1243.238.camel@phantasy> <20011009230007.B12825@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011009230007.B12825@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:00:07PM -0700, Mike Fedyk wrote:
> On Wed, Oct 10, 2001 at 01:34:41AM -0400, Robert Love wrote:
> > On Wed, 2001-10-10 at 01:24, Mike Fedyk wrote:
> > > On Wed, Oct 10, 2001 at 01:15:25AM -0400, Robert Love wrote:
> > > >
> > > > Ahh, yes.  Thank you for spotting this.  include/asm-i386/spinlock.h has
> > > > two separate defines for spin_unlock and we only renamed one of them.  I
> > > > guess you hit the conditional that used the other define...
> > > >
> > > > The attached patch fixes it.
> > > >
> > > 
> > > Thank you.  Will compile now...
> > 
> > Let me know, I didn't test :)
> > 
> > If it works I will merge it...
> >
> 
> Compilation success.
> 
> Will boot and run over the next couple days.
>

Ok, I've been running it for the last 16 hours under normal (light)
workstation load.

No problems.

Mike
