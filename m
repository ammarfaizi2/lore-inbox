Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVGULLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVGULLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGULLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:11:24 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:5395 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261751AbVGULLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:11:22 -0400
Message-ID: <42DF82D9.30202@blueyonder.co.uk>
Date: Thu, 21 Jul 2005 12:11:21 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: kdb v4.4 supports OHCI keyboard in 2.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jul 2005 11:12:07.0069 (UTC) FILETIME=[07F8A4D0:01C58DE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c:809: error: redefinition of `do_int3'
arch/i386/kernel/traps.c:709: error: `do_int3' previously defined here
make[1]: *** [arch/i386/kernel/traps.o] Error 1
make: *** [arch/i386/kernel] Error 2

Both lines are the same, enabling both kprobes and kdb causes the error, 
so kprobes must be deselected.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
