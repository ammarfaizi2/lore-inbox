Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279531AbRJ2VSQ>; Mon, 29 Oct 2001 16:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279535AbRJ2VSG>; Mon, 29 Oct 2001 16:18:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279531AbRJ2VRt>; Mon, 29 Oct 2001 16:17:49 -0500
Subject: Re: Need blocking /dev/null
To: marko@pacujo.nu (Marko Rauhamaa)
Date: Mon, 29 Oct 2001 21:24:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110292107.NAA09665@lumo.pacujo.nu> from "Marko Rauhamaa" at Oct 29, 2001 01:07:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yJtV-00044i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I noticed that I need a pseudodevice that opens normally but blocks all
> reads (and writes). The only way out would be through a signal. Neither

Try using a pipe
