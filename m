Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265481AbRFVRvj>; Fri, 22 Jun 2001 13:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265483AbRFVRv3>; Fri, 22 Jun 2001 13:51:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8460 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265482AbRFVRvU>; Fri, 22 Jun 2001 13:51:20 -0400
Subject: Re: For comment: draft BIOS use document for the kernel
To: root@chaos.analogic.com
Date: Fri, 22 Jun 2001 18:50:40 +0100 (BST)
Cc: RSchilling@affiliatedhealth.org (Schilling Richard),
        alan@lxorguk.ukuu.org.uk ('Alan Cox'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.3.95.1010622133759.3929A-100000@chaos.analogic.com> from "Richard B. Johnson" at Jun 22, 2001 01:42:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DV4q-0003qv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I could not find any reference to BIOS int 0x15, function 0x87, block-
> move, used to copy the kernel to above the 1 megabyte real-mode
> boundary. I think this is still used.

I dont think the kernel has ever used it. The path has always been to enter
32bit mode then relocate/uncompress the kernel, then run it

