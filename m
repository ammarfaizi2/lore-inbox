Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSATAaf>; Sat, 19 Jan 2002 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSATAa0>; Sat, 19 Jan 2002 19:30:26 -0500
Received: from smtp2.orcon.net.nz ([210.55.12.15]:34565 "EHLO
	smtp2.orcon.net.nz") by vger.kernel.org with ESMTP
	id <S287764AbSATAaQ>; Sat, 19 Jan 2002 19:30:16 -0500
Message-ID: <006701c1a149$b1321ae0$0100000a@orcon.net>
From: "Craig Whitmore" <lennon@orcon.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: Problems with ipip and ipgre in 2.4.17 (Missing nf_hooks)
Date: Sun, 20 Jan 2002 13:30:41 +1300
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

Hi there.. Is this a know Problem? Using 2.4.17

aknx3:/root# modprobe ipip
/lib/modules/2.4.17/kernel/net/ipv4/ipip.o: unresolved symbol nf_hooks
/lib/modules/2.4.17/kernel/net/ipv4/ipip.o: unresolved symbol nf_hook_slow
/lib/modules/2.4.17/kernel/net/ipv4/ipip.o: insmod
/lib/modules/2.4.17/kernel/net/ipv4/ipip.o failed
/lib/modules/2.4.17/kernel/net/ipv4/ipip.o: insmod ipip failed
aknx3:/root# modprobe ip_gre
/lib/modules/2.4.17/kernel/net/ipv4/ip_gre.o: unresolved symbol nf_hooks
/lib/modules/2.4.17/kernel/net/ipv4/ip_gre.o: unresolved symbol nf_hook_slow
/lib/modules/2.4.17/kernel/net/ipv4/ip_gre.o: insmod
/lib/modules/2.4.17/kernel/net/ipv4/ip_gre.o failed
/lib/modules/2.4.17/kernel/net/ipv4/ip_gre.o: insmod ip_gre failed

Thanks
Craig Whitmore
Orcon Internet
http://www.orcon.net.nz

