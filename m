Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131390AbRAFMKf>; Sat, 6 Jan 2001 07:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRAFMKZ>; Sat, 6 Jan 2001 07:10:25 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:378 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S131390AbRAFMKS>; Sat, 6 Jan 2001 07:10:18 -0500
Date: Sat, 6 Jan 2001 13:10:16 +0100
Message-Id: <200101061210.f06CAGa01969@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 TCP SYN problem
In-Reply-To: <200101060050.QAA09725@pizda.ninka.net>
X-Newsgroups: lt.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.4.0 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101060050.QAA09725@pizda.ninka.net> you wrote:

>   When I initiate connection from Solaris machine everything goes OK. 
>   TCP/SYN,ACK segments are OK.

>   Can anyone help me?

> Does:

> bash# echo "0" >/proc/sys/net/ipv4/tcp_ecn

Or maybe it?
echo "1" > /proc/sys/net/ipv4/ip_no_pmtu_disc

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
