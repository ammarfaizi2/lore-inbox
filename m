Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVGSJvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVGSJvk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 05:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGSJvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 05:51:40 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:9426 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S261939AbVGSJvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 05:51:39 -0400
X-Remote-IP: 213.191.142.124
X-Remote-IP: 213.191.128.21
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: Problems with reboot/poweroff on SMP machine
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
Date: Tue, 19 Jul 2005 11:51:37 +0200
Message-ID: <dnwtnn3yza.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric and all!

Last few weeks or so I started having problems with reboot/poweroff on
my aging SMP desktop (dual PIII, Apollo Pro 266 chipset). The machine
does all steps til' the very end where it stops (hangs) before the
actual reboot or poweroff. The problem doesn't happen every time (but
occasionally). Alt-SysRQ-B/O doesn't work at the point of hang.

I did a little bit of investigation and I believe that this patch:

 http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dd2a13054ffc25783a74afb5e4a0f2115e45f9cd

is the primary suspect for the regression (reboots and poweroffs have
been working fine for the last few years on this particular
machine). But now I need expert help. :) I'm willing to help decipher
this, so don't hesitate to ask for more details! I don't even know
what info is useful to provide at this point (kernel is virgin 2.6.12,
ACPI is compiled in, I don't use any boot time reboot= parameter, what
else?). And please Cc: me 'cause I'm not on the list.

Thanks for any info!
-- 
Zlatko
