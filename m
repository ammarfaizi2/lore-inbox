Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVCYRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVCYRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCYRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 12:03:25 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:20111 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261237AbVCYRDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 12:03:21 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3
Date: Fri, 25 Mar 2005 17:46:09 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050325002154.335c6b0b.akpm@osdl.org>
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503251746.10458.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

mm3 still not booting on my machine. Boot option 'nmi_watchdog=2' (my cpu is a 
dual core pentium 4 HT, 2.60 GHz) gets me a bit further in the boot process 
but it blocks there too.

[output retyped from screen]:
kernel: [    4.109241] PM: Checking swsusp image.
kernel: [    4.109244] PM: Resume from disk failed.
kernel: [    4.112220] VFS: Mounted root (ext2 filesystem) readonly. 
kernel: [    4.112465] Freeing unused kernel memory: 188k freed 
kernel: [    4.142002] logips2pp: Detected unknown logitech mouse model 1
kernel: [    4.274620] input: PS/2 Logitech Mouse on isa0060/serio1 
<--- [point of previous blocks without boot option 'nmi_watchdog=2']--->
INIT: version 2.86 booting
Mounting a tmpfs over /dev... done.
Creating initial device nodes... done.
Setting parameters of disc: (none).
Activating swap.
kernel: [   10.712648] Adding 976744k swap on /dev/hda2. Priority:-1 extents:1
Checking root file system...
fsck 1.36 (05-Feb-2005)
/: clean, 127290/1831424 files, 898566/3662056 blocks
[EOF]

Regards,
Boris.
