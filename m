Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285441AbRLGJHS>; Fri, 7 Dec 2001 04:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285442AbRLGJHH>; Fri, 7 Dec 2001 04:07:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285441AbRLGJGz>; Fri, 7 Dec 2001 04:06:55 -0500
Subject: Re: kernel: ldt allocation failed
To: vkire@pixar.com (Kiril Vidimce)
Date: Fri, 7 Dec 2001 09:15:48 +0000 (GMT)
Cc: dmaas@dcine.com (Dan Maas), linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com> from "Kiril Vidimce" at Dec 07, 2001 01:00:19 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CH6i-00059b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see how one can magically tell that this is an NVIDIA problem. 

We don't know. But since we don't have their source and they have our
source only they can tell you.

> in the kernel and I imagine that even if the NVIDIA drivers are 
> triggering the problem, there are other modules/apps that can bring 
> about the same behavior.

Possibly, but you'll have to ask Nvidia to debug it for you. If you can
reproduce a bug by 
	-	removing the nvidia modules so they wont be loaded
	-	hard booting the machine
	-	triggering the bug without loading the nvidia drivers

then please report it. If not, its between you and nvidia.
