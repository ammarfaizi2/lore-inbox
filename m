Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278490AbRJVKkO>; Mon, 22 Oct 2001 06:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278491AbRJVKkE>; Mon, 22 Oct 2001 06:40:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278490AbRJVKjy>; Mon, 22 Oct 2001 06:39:54 -0400
Subject: Re: 2.4.12-ac5: i810_audio does not work
To: pavenis@latnet.lv (Andris Pavenis)
Date: Mon, 22 Oct 2001 11:46:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200110221036.f9MAaDt03374@hal.astr.lu.lv> from "Andris Pavenis" at Oct 22, 2001 01:36:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vcbD-0001Vn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sound practically doesn't work under KDE-2.2.1. For example I'm getting only 
> some garbled sound for a very short time when I'm trying sound test in kcontrol. 
> Maybe these problems are due to non blocking output to /dev/sound/dsp 
> which artsd is using. Here is fragment from strace output for artsd

Do you know which release it actually broke for you ? By -ac5 there are
both core changes and multi-channel stuff that might be involved
