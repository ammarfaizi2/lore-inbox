Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289943AbSAKM74>; Fri, 11 Jan 2002 07:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289942AbSAKM7q>; Fri, 11 Jan 2002 07:59:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28164 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289941AbSAKM7d>; Fri, 11 Jan 2002 07:59:33 -0500
Subject: Re: strange kernel message when hacking the NIC driver
To: timothy.covell@ashavan.org
Date: Fri, 11 Jan 2002 13:11:05 +0000 (GMT)
Cc: zhengpei@msu.edu (Pei Zheng), linux-kernel@vger.kernel.org
In-Reply-To: <200201111159.g0BBxCSr001144@svr3.applink.net> from "Timothy Covell" at Jan 11, 2002 05:55:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P1Sb-0007b9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me clarify what I said earlier.  You cannot have
> identical MAC addresses on two different NICs.   Indeed,
> it is impossible w/o trying to fool the kernel into
> redefining the NICs hardware based MAC address. 

Wrong

A mac address is per system. Now in fact almost all systems do it per ethernet
card but that is not what the specifications guarantee. There are machines
out there and cards out there which use the same MAC on all interfaces.
