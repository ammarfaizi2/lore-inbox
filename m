Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271958AbRHVKpd>; Wed, 22 Aug 2001 06:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271959AbRHVKpX>; Wed, 22 Aug 2001 06:45:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271958AbRHVKpK>; Wed, 22 Aug 2001 06:45:10 -0400
Subject: Re: Oops when accessing /dev/fd0 (kernel 2.4.7 and devfsd 1.3.11)
To: steve@navaho.co.uk (Steve Hill)
Date: Wed, 22 Aug 2001 11:47:18 +0100 (BST)
Cc: taylorcc@codecafe.com (Taylor Carpenter),
        rgooch@ras.ucalgary.ca (Richard Gooch), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0108220955470.18880-100000@sorbus.navaho> from "Steve Hill" at Aug 22, 2001 10:00:47 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZVXa-0001Jb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noticed kernels 2.4.7, 2.4.8 and 2.4.9 can oops when modprobing
> floppy.o under certain circumstances (specifically I've noticed it when

floppy.o crashes the box or prints bad things if there is no floppy 
controller. I've not yet had time to investigate
