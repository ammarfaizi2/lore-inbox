Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUKAAxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUKAAxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 19:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKAAxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 19:53:25 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:36621 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261711AbUKAAxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 19:53:07 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org
From: Tim Connors <tconnors+linuxkernel1099270119@astro.swin.edu.au>
Subject: Re: [PATCH] Configurable Magic Sysrq
In-reply-to: <20041031185222.GB5578@elf.ucw.cz>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041031185222.GB5578@elf.ucw.cz>
X-test-to: Pavel Machek <pavel@suse.cz>
X-cc-to: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org
X-reply-to-bofh-messageid: <2Vt61-259-21@gated-at.bofh.it>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-16240-29609-200411011148-tc@hexane.ssi.swin.edu.au>
Date: Mon, 1 Nov 2004 11:52:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said on Sun, 31 Oct 2004 19:52:22 +0100:
> Hi!
> 
> >   I know about a few people who would like to use some functionality of
> > the Magic Sysrq but don't want to enable all the functions it provides.
> > So I wrote a patch which should allow them to do so. It allows to
> > configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> > interface is backward compatible). If you think it's useful then use it :)
> > Andrew, do you think it can go into mainline or it's just an overdesign?
> 
> Actually, there's one more thing that wories me... Original choice of
> PC hotkey (alt-sysrq-key) works *very* badly on many laptop
> keyboards. Like sysrq is only recognized with fn, but key is not
> recognized when you hold fn => you have no chance to use magic sysrq.
> 
> Perphaps sysrq could be made prefix notation? Like alt-sysrq, release,
> press s is sync?

It seems to already do that for me.

What I do have, is some bizzaaro hardware that gives some weird escape
keycode for alt-sysreq, so alt-sysreq s,u,b doesn't work. Could be the
fact that it is a PS2 keyboard plugged into an old AT style connector,
or something else, but I don't know where to start looking to fix
it. It's a relatively recent and relatively clean debian install, and
I don't know what I did wrong - I noticed this behaviour pretty much
from the start.

Maybe I'm asking for not just alt to be the prefix, maybe give the
choice of ctrl, etc. But I have a feeling ctrl is kinda funky on the
console of this machine as well.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
ALU n. Arthritic Logic Unit, or (rare) Arithmetic Logic Unit. A random
number generator supplied as standard with all computer systems. --unk
