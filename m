Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRJHSXk>; Mon, 8 Oct 2001 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277065AbRJHSXa>; Mon, 8 Oct 2001 14:23:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276982AbRJHSXN>; Mon, 8 Oct 2001 14:23:13 -0400
Subject: Re: linux-2.4.10-acX
To: louisg00@bellsouth.net (Louis Garcia)
Date: Mon, 8 Oct 2001 19:29:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1002565315.8915.1.camel@tiger> from "Louis Garcia" at Oct 08, 2001 02:21:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qf9M-0001RL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has raw/block I/O changes from linus 2.4.10 been merged?

No. There were certain bits of 2.5^H4.10 that I took one look at and threw
out for the moment as unsafe for a stable tree - the page cache block
device and O_DIRECT stuff included. 

2.4.11pre seems to back some of that out too.
