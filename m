Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277756AbRJMLFi>; Sat, 13 Oct 2001 07:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277720AbRJMLF2>; Sat, 13 Oct 2001 07:05:28 -0400
Received: from pop.gmx.net ([213.165.64.20]:38923 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276857AbRJMLFO>;
	Sat, 13 Oct 2001 07:05:14 -0400
Message-ID: <004801c153d6$ffc398c0$0100005a@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Date: Sat, 13 Oct 2001 13:05:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iptables keeps telling me that whenever i run it although i got the latest
kernel, latest iptables and all modules required for iptables are loaded (it
also doesnt work when i compile them into the kernel)!
anyone got an idea how to fix this?


[root@HOST2 /]# iptables -L
iptables v1.2.3: can't initialize iptables table `filter': Module is wrong
version
Perhaps iptables or your kernel needs to be upgraded.
[root@HOST2 /]# cat /proc/version
Linux version 2.4.12 (root@HOST2) (gcc version 2.96 20000731 (Mandrake Linux
8.1 2.96-0.62mdk)) #1 Sat Oct 13 12:12:08 CEST 2001
[root@HOST2 /]# grep _NF_ /usr/src/linux/.config
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
CONFIG_IP_NF_MATCH_STATE=m
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
# CONFIG_IP_NF_TARGET_REJECT is not set
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
# CONFIG_IP_NF_TARGET_REDIRECT is not set
CONFIG_IP_NF_NAT_FTP=m
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set




