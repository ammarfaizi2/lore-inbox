Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUFAWlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUFAWlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265271AbUFAWkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:40:32 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:18309 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S265261AbUFAWbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:31:36 -0400
Message-ID: <40BD03C8.5060504@mnsu.edu>
Date: Tue, 01 Jun 2004 17:31:36 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aacraid hangs at boot on linux-2.4.27-pre1 20 second delay at lilo
 prompt makes it succeed
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting linux-2.4.27-pre1 the system hangs.  If I put a 20 second 
delay in at the lilo prompt then the system always boot successfully.  
...I just pulled 20 seconds out of the air... less time might work,  but 
I haven't tried.  I've also tried linux-2.4.24 with the same results.

I've since updated the system and raid card to the most current bios. 
and it hasn't helped.  The old raid bios was build 6082.

The system hangs right before the "Red Hat/Apaptec..." line below.

dmesg:
Red Hat/Adaptec aacraid driver (1.1-3 Apr 22 2004 14:34:42)
AAC0: kernel 2.8.4 build 6089
AAC0: monitor 2.8.4 build 6089
AAC0: bios 2.8.0 build 6089
AAC0: serial 635081d3fafaf001
scsi0 : percraid
  Vendor: DELL      Model:                   Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
megaraid: v1.18k (Release Date: Thu Aug 28 10:05:11 EDT 2003)
megaraid: no BIOS enabled.

/proc/version:
Linux version 2.4.27-pre1 (ricardo@krypton) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 SMP Thu Apr 22 14:33:58 CDT 2004


