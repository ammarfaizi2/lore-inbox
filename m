Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVACVL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVACVL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVACVHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:07:45 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41947 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261874AbVACVES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:04:18 -0500
Message-Id: <200501032103.j03L33eb004694@laptop11.inf.utfsm.cl>
To: Bill Davidsen <davidsen@tmr.com>
cc: Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: Message from Bill Davidsen <davidsen@tmr.com> 
   of "Mon, 03 Jan 2005 12:18:36 CDT." <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 03 Jan 2005 18:03:03 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> said:

[...]

> I have to say that with a few minor exceptions the introduction of new
> features hasn't created long term (more than a few days) of problems. And
> we have had that in previous stable versions as well. New features
> themselves may not be totally stable, but in most cases they don't break
> existing features, or are fixed in bk1 or bk2. What worries me is removing
> features deliberately, and I won't beat that dead horse again, I've said
> my piece.
> 
> The "few minor exceptions:"
> 
> SCSI command filtering - while I totally support the idea (and always
> have), I miss running cdrecord as a normal user. Multisession doesn't work
> as a normal user (at least if you follow the man page) because only root
> can use -msinfo. There's also some raw mode which got a permission denied,
> don't remember as I was trying something not doing production stuff.

It had very nasty security problems. After a short discussion here, it was
deemed much more important to have a secure system than a (very minor)
convenience. AFAIU, the patch was backported to 2.4 (or should be ASAP).

> APM vs. ACPI - shutdown doesn't reliably power down about half of the
> machines I use, and all five laptops have working suspend and non-working
> resume. APM seems to be pretty unsupported beyond "use ACPI for that."

Many never machines just don't have APM.

> None of these would prevent using 2.6 if there were some feature not in
> 2.4 which gave a reason to switch.

Like 2.6 works fine, 2.4 has no chance on some machines?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

