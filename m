Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUCYA2p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbUCYAZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:25:26 -0500
Received: from gprs214-165.eurotel.cz ([160.218.214.165]:11396 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262902AbUCYAX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:23:27 -0500
Date: Thu, 25 Mar 2004 01:23:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]]
Message-ID: <20040325002302.GG290@elf.ucw.cz>
References: <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th> <20040324101704.GA512@elf.ucw.cz> <opr5d1jave4evsfm@smtp.pacific.net.th> <20040324232338.GE290@elf.ucw.cz> <opr5d4r0il4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <opr5d4r0il4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-03-04 07:56:14, Michael Frank wrote:
> On Thu, 25 Mar 2004 00:23:38 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> >On Čt 25-03-04 06:46:12, Michael Frank wrote:
> >>On Wed, 24 Mar 2004 11:17:04 +0100, Pavel Machek <pavel@ucw.cz> wrote:

> >Yes, having -nice patch with bootsplashes, translated kernel messages,
> >and swsusp eye-candy would work for me.
> 
> If a -nice _tree_ is useful, your guys just have to launch it. Gosh this 
> could reduce
> arguments about what goes into the kernel and save Linus and Andrew lots of 
> work.

Yes.
 
> >Feel free to maintain it.
> 
> Busy enough with testing, actually far too busy for being on a volunteer 
> basis ;)
> 
> I am sure that better qualified and properly supported/sponsored individuals
> will queue up as long as it is an _official_ -nice tree with the good 
> purpose
> of centralizing useful non-core functions :)

I'd say that having official -anything tree is an oxymoron (is -ac
tree official? is -mm tree official?), but yes, I hope someone picks
this up

> >You see, 10 lines in printk is probably good enough reason not to
> >include that patch in kernel, because its "too ugly".
> 
> Pretty does not count above, Ugly does not count here, Functionality always 
> does.
> Besides that patch might be in the -nice tree.

Prettyness *does* count in -linus tree. -nice tree is likely to have
different criteria.

> >swsusp really should not have patch any code outside kernel/power.
> 
> Which is extremely ideal, but one thing at the time...

Okay, lets not please add more of outside changes (for -linus merge).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
