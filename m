Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133102AbRDLLcC>; Thu, 12 Apr 2001 07:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133104AbRDLLbw>; Thu, 12 Apr 2001 07:31:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30739 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133102AbRDLLbm>; Thu, 12 Apr 2001 07:31:42 -0400
Subject: Re: PROBLEM: Linux 2.2.19 system crash with Oops in scsi_do_cmd during
To: daniel.deimert@intermec.com (Daniel Deimert)
Date: Thu, 12 Apr 2001 12:33:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, alan@redhat.com
In-Reply-To: <3AD58DE9.2C348241@intermec.com> from "Daniel Deimert" at Apr 12, 2001 01:13:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nfM9-0000M7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.] One line summary of the problem:
> 
> Linux 2.2.19 system crash with Oops in scsi_do_cmd during mirror rebuild
> on megaraid

Can you duplicate it without the intel modules being loaded that boot

> Before I attempted to rebuild the mirror set, I got several kernel
> messages like this
>     kernel: scsidisk I/O error: dev 08:11, sector 71077808
> This is on a mirrored partition that the megaraid utility verified to be
> flawless.

Thats the scsi driver reporting a failure from the controller. I've seen this
before where the bios said all was fine and there were real problems. What
matters to me more is the rest of the 'scsidisk I/O error' message block 
giving the reason why it errored

