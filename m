Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273648AbRJJGAS>; Wed, 10 Oct 2001 02:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJJGAB>; Wed, 10 Oct 2001 02:00:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34546
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273648AbRJJF7l>; Wed, 10 Oct 2001 01:59:41 -0400
Date: Tue, 9 Oct 2001 23:00:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile Filure on 2.4.10-ac10+preempt+smp
Message-ID: <20011009230007.B12825@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011009214655.A26663@mikef-linux.matchmail.com> <1002690949.862.233.camel@phantasy> <20011009222403.A12825@mikef-linux.matchmail.com> <1002692093.1243.238.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002692093.1243.238.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 01:34:41AM -0400, Robert Love wrote:
> On Wed, 2001-10-10 at 01:24, Mike Fedyk wrote:
> > On Wed, Oct 10, 2001 at 01:15:25AM -0400, Robert Love wrote:
> > >
> > > Ahh, yes.  Thank you for spotting this.  include/asm-i386/spinlock.h has
> > > two separate defines for spin_unlock and we only renamed one of them.  I
> > > guess you hit the conditional that used the other define...
> > >
> > > The attached patch fixes it.
> > >
> > 
> > Thank you.  Will compile now...
> 
> Let me know, I didn't test :)
> 
> If it works I will merge it...
>

Compilation success.

Will boot and run over the next couple days.

> > > I only keep around patches to the last official kernel, plus the latest
> > > -pre and -ac I patched.  Since the patch itself is being updated, its a
> > > pain to backport to older kernels.
> > >
> > 
> > No, I'm not asking for backport, just links to one version back just in case
> > the latest patch has a bug much like this...
> > 
> > I'd rather run one (working) version back than have to go to UP just to get
> > preempt...  Needless to say, I chose to keep smp.
> 
> OK, then try editing the URL, I scp the patches in and don't ssh in and
> actually clean the stuff up but every here and there.
> 
> ie, change the ac10 to ac9 in the URL.
> 

Yep, thought of that, but didn't try it.  I figured it would be better to
report than to go silent...

Mike
