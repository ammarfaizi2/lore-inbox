Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWGPRqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWGPRqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 13:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWGPRqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 13:46:04 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:53402 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751104AbWGPRqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 13:46:02 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc2 ATA Errors
Date: Sun, 16 Jul 2006 13:46:00 -0400
User-Agent: KMail/1.9.3
X-Face: M;&!dfz|m-o'K\Cz\J=6-U&/;8+edm=snaTAX=*NtQpWX@156L1%mHDt3XI%X!5Hw3U+pe
	nazcjJnz>75*V8\Sz\]3brW#a+Oa,8P7p6L+sVZkP;ZwyeKR0o`*#k2zD&!2Mn,0d3<7qa
	6%>g:?bp|XU>`.|?x2l;ounL%k85<JW7G=Df&(@a?]WbFJ{3aEyx4\`#@JXn|4Le8c;bgI
	JIayR9DG$hLN8![[*`T_Y{x(y>T/KB"2a|vqpcO*?ngOt-V0Lo5nTA{)k+Pm|okhK`[ikO
	;lvKCYCBdfs~Q
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607161346.00352.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw the below error in dmesg - (ATA2 is my CD burner and I wasn't doing 
anything with it as far as I remember) . Drive seems to work fine after the 
error. What does it mean?

$ dmesg |grep ata2
[    1.496000] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
[    1.836000] ata2.00: ATAPI, max UDMA/33
[    2.016000] ata2.00: configured for UDMA/33
[44087.904000] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 
frozen
[44087.904000] ata2.00: tag 0 cmd 0xa0 Emask 0x2 stat 0x50 err 0x0 (HSM 
violation)
[44087.904000] ata2: soft resetting port
[44088.340000] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[44088.340000] ata2.00: revalidation failed (errno=-5)
[44088.340000] ata2: failed to recover some devices, retrying in 5 secs
[44093.344000] ata2: soft resetting port
[44093.876000] ata2.00: configured for UDMA/33
[44093.876000] ata2: EH complete
