Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278481AbRJZOan>; Fri, 26 Oct 2001 10:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278483AbRJZOae>; Fri, 26 Oct 2001 10:30:34 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278481AbRJZOaX>; Fri, 26 Oct 2001 10:30:23 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
To: sgy@amc.com.au (Stuart Young)
Date: Fri, 26 Oct 2001 15:36:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, compumike@compumike.com (Michael F. Robbins),
        rml@tech9.net (Robert Love),
        tachino@open.nm.fujitsu.co.jp (Tachino Nobuhiro),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <5.1.0.14.0.20011026125325.024517e0@mail.amc.localnet> from "Stuart Young" at Oct 26, 2001 01:24:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15x86H-0000GV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I find out the ac97 codec ID for this chipset (if there is one) so 
> it can be added to the ac97_codec_ids array? From what I can tell, it's as 
> though the codec->codec_read(codec, AC97_VENDOR_ID#) isn't returning the 
> codec value for this system at all.

Something is failing to bring up the AC97 codec bus and/or set it up
properly. Can you find exactly which patch broke that for you (you'll 
possibly want to keep fixing the codec table as you test older ones)
