Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUKOKhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUKOKhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUKOKhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:37:18 -0500
Received: from isma.kharkov.ua ([217.144.73.247]:35781 "EHLO
	www.isma.kharkov.ua") by vger.kernel.org with ESMTP id S261362AbUKOKhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:37:10 -0500
Message-ID: <419886CE.2030304@isma.kharkov.ua>
Date: Mon, 15 Nov 2004 12:37:02 +0200
From: zergio <zergio@isma.kharkov.ua>
Organization: =?UTF-8?B?0JjQodCc0JA=?=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru-RU; rv:1.7.4) Gecko/20040926
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.27 suddenly hangs
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all!
I‘m not sure that the below problem is kernel related, however, I think, 
this mailing list is the best place to start. I've got 2x1.8 Xeon on 
Intel SE7500CW2 motherboard with Intel SCSI RAID (GDT driver). The 
system powered by Red Hat Linux 7.3 with custom kernel version 2.4.27.
Occasionally, the system just hangs, without giving any error messages 
to syslog or any panic-like messages to the screen. No response to ping. 
Usually it happens on weekends in early hours, but not at particular 
time and day, when users’ activity is minimal. Couple of times the last 
few messages before, the hang had strange timestamps. It seems like the 
system time entered a TIME LOOP within a period of 1 second.
Nov 6 05:37:31 service dhcpd: Message...
Nov 6 05:37:32 service named: Message...
Nov 6 05:37:31 service named: Message...
Almost all the time last messages came from different services, except 
three times, when mgetty was the last. I'd updated mgetty, pppd, kernel 
(from 2.4.20), BIOS, dhcpd etc., however, the problem remains.
Can anyone tell me, how I can detect, what application or hardware cause 
such a problem.
Any ideas would be appreciated.
Thank you in advance

These are services being run on the server:
gpm
named
iptables
crond
ldap
smb
xinetd (swat amanda)
autofs
nfs
qmail
sqwebmail
dhcpd
ups
sshd
firebird
ntpd
httpd
arpwatch
drwebd
mgetty
pppd
postgresql



