Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUCYBla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 20:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUCYBla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 20:41:30 -0500
Received: from gprs214-165.eurotel.cz ([160.218.214.165]:58756 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263089AbUCYBl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 20:41:27 -0500
Date: Thu, 25 Mar 2004 02:41:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040325014107.GB6094@elf.ucw.cz>
References: <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th> <20040324101704.GA512@elf.ucw.cz> <opr5d1jave4evsfm@smtp.pacific.net.th> <20040324232338.GE290@elf.ucw.cz> <opr5d4r0il4evsfm@smtp.pacific.net.th> <20040325002302.GG290@elf.ucw.cz> <opr5d7ad0b4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <opr5d7ad0b4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-03-04 08:50:27, Michael Frank wrote:
> On Thu, 25 Mar 2004 01:23:02 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> 
> >On Čt 25-03-04 07:56:14, Michael Frank wrote:
> >>On Thu, 25 Mar 2004 00:23:38 +0100, Pavel Machek <pavel@ucw.cz> wrote:

> >>I am sure that better qualified and properly supported/sponsored 
> >>individuals
> >>will queue up as long as it is an _official_ -nice tree with the good
> >>purpose
> >>of centralizing useful non-core functions :)
> >
> >I'd say that having official -anything tree is an oxymoron (is -ac
> >tree official? is -mm tree official?), but yes, I hope someone picks
> >this up
> 
> -mm or -ac are "private trees", albeit very credible and at least -mm is
> experimental.

Having credible "private" -nice tree would be enough, I guess.

> >>Which is extremely ideal, but one thing at the time...
> >
> >Okay, lets not please add more of outside changes (for -linus merge).
> 
> Fine by me as long as it works.
> 
> Guess Nigel will come up with a spec soon and then it has to be decided
> what functions you want in -Linus.

My priorities are

* highmem support (there are notebooks with 2GB ram; I have one too
  close to me)
  [I have hacky patch for this for swsusp1; at least its short]

* smp support (HT notebooks are going to be more common, I'm afraid)

Important but not at price of modifying too many files outside
kernel/power

* refrigerator should work (but if you have NFS server mounted, and
  its down, you are on your own)

* even if all memory is used, it should be possible to suspend

"If it is very non-intrusive it might go in"

* esc interrupts

* I'd say that one compression method should be enough for everyone

Features I'd prefer not to see in -linus kernel

* splashscreen

* /proc configuration
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
