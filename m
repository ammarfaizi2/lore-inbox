Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKOAB2>; Wed, 14 Nov 2001 19:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278685AbRKOABT>; Wed, 14 Nov 2001 19:01:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278665AbRKOABB>; Wed, 14 Nov 2001 19:01:01 -0500
Subject: Re: generic_file_llseek() broken?
To: adilger@turbolabs.com (Andreas Dilger)
Date: Thu, 15 Nov 2001 00:08:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20011114165147.S5739@lynx.no> from "Andreas Dilger" at Nov 14, 2001 04:51:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164A4l-0006SR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was recently testing a bit with creating very large files on ext2/ext3
> (just to see if limits were what they should be).  Now, I know that ext2/3
> allows files just shy of 2TB right now, because of an issue with i_blocks
> being in units of 512-byte sectors, instead of fs blocks.

Does 2.4.13-ac7 show the same. There were some off by one fixes and its
possible I managed to forget to feed Linus one
