Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131773AbRCUThh>; Wed, 21 Mar 2001 14:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131774AbRCUTh2>; Wed, 21 Mar 2001 14:37:28 -0500
Received: from smtp7.xs4all.nl ([194.109.127.133]:27350 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S131773AbRCUThT>;
	Wed, 21 Mar 2001 14:37:19 -0500
Date: Wed, 21 Mar 2001 19:34:47 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: max ip_conntrack entries
Message-ID: <20010321193447.A555@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux grobbebol 2.4.2-ac20 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


is there a way to dynamically change the limit : kernel: ip_conntrack:
maximum limit of 16384 entries exceeded ?

grepping in the documentation didn't tell much here.

either a newssus scan or a weird ftp server I tried to connect to,
caused the table to fill pretty fast and all other connections stopped
for a short time.

the entries are similar btw in /proc/net/ip_conntrack :

tcp      6 425335 ESTABLISHED src=203.45.72.96 dst=203.45.72.96
sport=28480 dport=21 [UNREPLIED] src=203.45.72.96 dst=203.45.72.96
sport=21 dport=28480 use=1

the source and dest are always the same. weird. currently 15443
entries.


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
