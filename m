Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264537AbRFJQAt>; Sun, 10 Jun 2001 12:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbRFJQAj>; Sun, 10 Jun 2001 12:00:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50187 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264537AbRFJQAa>; Sun, 10 Jun 2001 12:00:30 -0400
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
To: stelian.pop@fr.alcove.com
Date: Sun, 10 Jun 2001 16:58:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010610175730.B15945@ontario.alcove-fr> from "Stelian Pop" at Jun 10, 2001 05:57:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1597bu-0006lf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. But, even if I know how to program the mchip to output to
> the video bus, there is something missing to enable overlay
> (either in the mchip or in the ati video driver).

It could be using the YUV digital inputs to the ATI chip. It seems however
also quite likely to me that windows is doing the following

1.	Issuing USB transfers which put the data into video ram overlay buffers
	(ie the DMA from the USB controller)

2.	Using the YUV overlay/expand hardware in the ATI card 
	(see www.gatos.org for X stuff for ATI for this)

> 

