Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277231AbRJIOI4>; Tue, 9 Oct 2001 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277237AbRJIOIq>; Tue, 9 Oct 2001 10:08:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2569 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277231AbRJIOIb>; Tue, 9 Oct 2001 10:08:31 -0400
Subject: Re: [LTP] VFS: brelse: started after 2.4.10-ac7
To: rwhron@earthlink.net
Date: Tue, 9 Oct 2001 15:14:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
In-Reply-To: <20011009094707.B4951@earthlink.net> from "rwhron@earthlink.net" at Oct 09, 2001 09:47:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qxeU-0004JI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About 2 minutes into "runalltests.sh" on ltp, ac kernels after 2.4.10-ac7
> give a message like:
> 
> Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer
> Oct  9 01:55:09 rushmore kernel: VFS: brelse: Trying to free free buffer

You are using reiserfs ? Certainly there appears to a buffer cache problem
with the remaining unmerged reiserfs changes from namesys that are in -ac.

Alan
