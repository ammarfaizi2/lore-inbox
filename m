Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbREMQ1L>; Sun, 13 May 2001 12:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbREMQ1B>; Sun, 13 May 2001 12:27:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261415AbREMQ0y>; Sun, 13 May 2001 12:26:54 -0400
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
To: viro@math.psu.edu (Alexander Viro)
Date: Sun, 13 May 2001 17:23:07 +0100 (BST)
Cc: szabi@inf.elte.hu (BERECZ Szabolcs), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105121935570.11973-100000@weyl.math.psu.edu> from "Alexander Viro" at May 12, 2001 07:39:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yyeB-0006fT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erm... Let me restate: what did you expect to achieve with that?
> Swap on device means that all contents of that device is lost.
> Mounting fs from device generally means that you don't want the
> loss of contents. At least until you unmount the thing.

Actually no. There is no swap magic so the swap fails. Unfortunately it 
appears to have hosed the mount in the meantime. 

Alan

