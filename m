Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUFPRm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUFPRm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUFPRm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:42:59 -0400
Received: from hostmaster.org ([212.186.110.32]:50560 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264299AbUFPRm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:42:57 -0400
Subject: Re: Linux 2.6.7 - ACPI still broken
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1087407777.2959.12.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Jun 2004 19:42:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As posted on 2004-06-07 ACPI support seems to be broken for Intel
D865PERL board since at least 2.6.7-rc2.

When booting with the standard flags (nmi_watchdog=1 root=/dev/md0
video=matroxfb:vesa:0x1bb) the kernel locks up with different error
messages immediately after "ACPI: Subsystem revision 20040326". Adding
"acpi=off" to the command line makes everything work again.

You can find my dmesg output (with "acpi=off") and my .config here:
http://www.hostmaster.org/~thomasz/linux-2.6.7-config
http://www.hostmaster.org/~thomasz/linux-2.6.7-dmesg

Tom


