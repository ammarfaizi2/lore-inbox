Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUAUVPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUAUVPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:15:35 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:2954 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261193AbUAUVPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:15:33 -0500
To: linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: Re: PROBLEM: ACPI freezes 2.6.1 on boot
From: "Georg C. F. Greve" <greve@gnu.org>
In-Reply-To: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Wed, 21 Jan 2004 22:15:24 +0100
Message-ID: <m3d69dhukz.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|| On 2004-01-21 18:56:59, Linus Torvalds wrote:

 > Does it go away if you just make "acpi_pic_set_level_irq()" do
 > nothing (ie just remove the "outb()" call
 > 
 > 	arch/i386/kernel/acpi/boot.c line 273
 > 
 > or just make the if-statement be always false).

 > It's entirely possible that the SCI is just horribly broken, and
 > can't be level-triggered.

Just tried removing the outb() call both from plain vanilla 2.6.1 and
one with the latest ACPI patch. No change. The system freezes with the
same message at the same point during bootup.

Any other ideas?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
