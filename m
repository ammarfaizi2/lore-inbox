Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUGEOlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUGEOlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGEOlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:41:50 -0400
Received: from web13903.mail.yahoo.com ([216.136.175.29]:39477 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266128AbUGEOlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:41:47 -0400
Message-ID: <20040705144146.34066.qmail@web13903.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 5 Jul 2004 07:41:46 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: 2.6.7-mm6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm6/
>
>- Added the DVD-RW/CD-RW packet writing patches. These need more work.
>
>- The USB update seems deadlocky. I fixed one bug but it still causes
my
>ia64 test box to lock up on boot. If it goes bad, please revert
>usb-locking-fix.patch and then revert bk-usb.patch. Retest and send a
report
>to linux-kernel and linux-usb-devel@xxxxxxxxxxxxxxxxxxxxxx

 same Omnibook problem as reported for mm1-mm3. If local APIC is
enabled in kernel config and "nolapic" is specified on boot line, the
notbook will hang in the Bogomips calibration loop.

 Only solutions so far are "acpi=no" (but no "nolapic") or taking local
APIC out of the configuration (which I will do from now on).

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
