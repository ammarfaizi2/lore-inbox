Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRLITHv>; Sun, 9 Dec 2001 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283780AbRLITHl>; Sun, 9 Dec 2001 14:07:41 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:44597 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S283782AbRLITH2>; Sun, 9 Dec 2001 14:07:28 -0500
Reply-To: <linux-kernel@pogrammers-world.com>
From: "Sascha Andres" <linux-kernel@programmers-world.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols (NOT A BUG)
Date: Sun, 9 Dec 2001 20:09:01 +0100
Message-ID: <002e01c180e4$f6568a50$0328a8c0@keasanb>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i try to add syslog support into net/ipv4/netfilter/ipt_LOG.c .
so i added  an include to sys/syslog.h and used the functions
in there.

i now get unresolved symbols for each function i use from syslog.h .

my question is, must i merge the whole syslog code to the kernel
for being able to use syslog in the above mentioned mod?

i added a 'firewall' facility to syslog and want all netfilter
logs coming throuh ipt_LOG log to this facility.

sorry if this sounds 'strange', but i'm relative new to the kernel
sources.

i started this cause i have not seen a possibility to log to
a specific facility with the klog daemon.

bye,

sascha

