Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268702AbRIJNd0>; Mon, 10 Sep 2001 09:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRIJNdQ>; Mon, 10 Sep 2001 09:33:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23819 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268702AbRIJNdH>; Mon, 10 Sep 2001 09:33:07 -0400
Subject: Re: [COMPILE FAILS] linux-2.4.10-pre7
To: steve@navaho.co.uk (Steve Hill)
Date: Mon, 10 Sep 2001 14:36:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0109101152120.22591-100000@sorbus.navaho> from "Steve Hill" at Sep 10, 2001 12:14:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15gRF2-0000e0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just tried compiling 2.4.10-pre7, and the build fails with the following
> errors... having grepped the source-tree, it seems that
> SCSI_IOCTL_FC_TARGET_ADDRESS and SCSI_IOCTL_FC_TDR aren't defined
> anywhere:

cpqfc relies on ioctls that arent in Linus tree. I think its been like that
for a while. Comment those cases out
