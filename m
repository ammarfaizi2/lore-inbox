Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSBMWdN>; Wed, 13 Feb 2002 17:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289036AbSBMWdD>; Wed, 13 Feb 2002 17:33:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54541 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289018AbSBMWcu>; Wed, 13 Feb 2002 17:32:50 -0500
Subject: Re: What does AddrMarkNotFound mean?
To: schepler@math.berkeley.edu (Daniel Schepler)
Date: Wed, 13 Feb 2002 22:46:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <873d059gzh.fsf@frobnitz.ddts.net> from "Daniel Schepler" at Feb 13, 2002 02:03:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16b8Ab-0006f6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this typical behavior for a hard drive which has developed bad
> blocks?  And if I blacklist the affected blocks in the filesystem,
> should I also blacklist a few previous blocks in order to avoid
> problems with the readahead feature of the IDE drivers?

Its a disk error (it can't find the index marks for a sector). In general
its a bad sign and you might want to check the smart data for the disk.

If you bought an IBM disk within the last 18 months or so check for new 
firmware, flash it if so and reformat it before panicing and assuming
the worst.

