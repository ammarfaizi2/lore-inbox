Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280634AbRKGDSR>; Tue, 6 Nov 2001 22:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280648AbRKGDSH>; Tue, 6 Nov 2001 22:18:07 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7409
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280634AbRKGDRz>; Tue, 6 Nov 2001 22:17:55 -0500
Date: Tue, 6 Nov 2001 19:17:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        Terminator <jimmy@mtc.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: Are -final releases realy FINAL? (Was Re: kernel 2.4.14 compiling fail for loop device)
Message-ID: <20011106191747.A20245@mikef-linux.matchmail.com>
Mail-Followup-To: Anuradha Ratnaweera <anuradha@gnu.org>,
	Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	Terminator <jimmy@mtc.dhs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org> <20011105194316.B665@mikef-linux.matchmail.com> <1005019360.897.2.camel@phantasy> <20011107091314.A11202@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107091314.A11202@bee.lk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:13:14AM +0600, Anuradha Ratnaweera wrote:
> On Mon, Nov 05, 2001 at 11:02:36PM -0500, Robert Love wrote:
> >
> > On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
> > >
> > > Did anyone have this problem with pre8???
> > 
> > Nope, it was added post-pre8 to final.  The deactivate_page function was
> > removed completely.
> 
> Look, Linus.  Things should _not_ happen this way.
> 
> Why do we add non-trivial changes when going from last -preX of a test kernel
> series to -final?
> 
> Please make the last stable -preX the -final _without_ any changes.  This is
> the third time this caused problem in recent times (2.4.11-dontuse, parport
> compile problems and now loop.o), and why don't we learn from previous
> mistakes?
> 
> Isn't it stupid that some tarballs in the /pub/linux/kernel/v2.4/ do not even
> compile, while those in /pub/linux/kernel/testing/ does?
> 

Here here.

You'd almost expect this from XP-beta to XP-final, but not Linux kernel...

Sorry, couldn't resist.

Mike
