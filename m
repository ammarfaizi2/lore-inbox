Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSDAWYX>; Mon, 1 Apr 2002 17:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312643AbSDAWYN>; Mon, 1 Apr 2002 17:24:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8708 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312638AbSDAWYC>; Mon, 1 Apr 2002 17:24:02 -0500
Subject: Re: Oops in emu10k1 driver
To: bloch@verdurin.com (Adam Huffman)
Date: Mon, 1 Apr 2002 23:41:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020401215107.GA28180@asus.verdurin.priv> from "Adam Huffman" at Apr 01, 2002 10:51:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sAU4-0000gd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> VMware died when I put an audio CD into my DVD drive.  I wouldn't have
> mentioned it here but for the fact that there was an Oops and when
> decoded it pointed to the emu10k1 driver:

Yes but we don't know what vmware has been doing. Please try the same thing
a few times without vmware running

> kernel BUG at audio.c:1474!
> invalid operand: 0000


This one does look like a real bug in the emu10k driver, rather than a
vmware caused funny
