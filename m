Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRKSJxO>; Mon, 19 Nov 2001 04:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRKSJxF>; Mon, 19 Nov 2001 04:53:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276761AbRKSJwu>; Mon, 19 Nov 2001 04:52:50 -0500
Subject: Re: Network packet drop?
To: bselu@web.de (Eckehardt Luhm)
Date: Mon, 19 Nov 2001 10:00:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF8B2CC.C172F67C@web.de> from "Eckehardt Luhm" at Nov 19, 2001 08:20:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165lES-00061j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> packets at the highest possible speed, simply by looping a
> sendto(socket, ...), which should block until a packet is out. What I

No. UDP is unreliable. The kernel will discard sender side, receive side and
anywhere else it feels like

Alan
