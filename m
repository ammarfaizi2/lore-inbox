Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVC2ReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVC2ReJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVC2ReJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:34:09 -0500
Received: from admin.eth0.us ([67.15.164.189]:2210 "EHLO admin.eth0.us")
	by vger.kernel.org with ESMTP id S261267AbVC2ReE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:34:04 -0500
From: "John Wigle" <forums@eth0.us>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 and .11 SCSI booting problems /w fusion card
X-Mailer: NeoMail 1.27
X-IPAddress: 152.17.63.39
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1DGKab-0001Hd-Aw@admin.eth0.us>
Date: Tue, 29 Mar 2005 12:33:17 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - admin.eth0.us
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32003 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - eth0.us
X-Source: /bin/bash
X-Source-Args: sh -c /usr/sbin/sendmail -oem -oi -F '"John Wigle"' -f 'forums@eth0.us' -t 1>&2 
X-Source-Dir: :/base
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for posting the last email without a subject, I am just resending
this one with a subject.

I am fairly new to the mailing list but have been playing around with
kernels for awhile. I have successfully built 2.4 and 2.6 kernels on
different types of remote servers but this latest problem has me
stumped. The config I am using was working fine under 2.6.9 but 2.6.10
and 2.6.11 both are not able to boot up. I have posted the config at
http://eth0.us/?q=node/39 if anybody is interested to look. On boot I
get the cannot mount /dev/sda3 every single time when trying with a
kernel above 2.6.9. 

I have tried with modules and without module support. 

The problem comes from the following SCSI card in a dell poweredge server:
SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)

The driver that the 2.4 kernel uses is:
alias scsi_hostadapter mptscsih

Does anybody have any idea why this is happening or what can be done to
get it to boot? I have tried to compile it on a many different servers
with the same results. I have also asked a few people and they have not
been able to get it working. Any ideas or pointers in the right
direction are GREATLY appreciated! I have searched google but so far
have found nothing useful. 


--
Best regards,
John Wigle
"eth00"
http://eth0.us

--
Best regards,
John Wigle
"eth00"
http://eth0.us
