Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266714AbRGLVcg>; Thu, 12 Jul 2001 17:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266608AbRGLVc0>; Thu, 12 Jul 2001 17:32:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59916 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266691AbRGLVcX>; Thu, 12 Jul 2001 17:32:23 -0400
Subject: Re: Adaptec SCSI driver lockups
To: llalonde@giref.ulaval.ca (Luc Lalonde)
Date: Thu, 12 Jul 2001 22:33:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B4E14E4.BF0497@giref.ulaval.ca> from "Luc Lalonde" at Jul 12, 2001 05:21:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ko5D-0006wh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that it is a problem with the Adaptec 39160 SCSI controller
> that is on my system (aic799).  The lockups always occur when I'm
> backing up to my HP DAT40 that is connected to channel A of this SCSI
> controller.  The strange thing is that I backup every night most of the
> time without problems to this tape.  

I had to switch to aic7xxx_old driver to get my aic7xxx box stable under
test loads. it worked fine until  I ran test suites then choked. aic7xxx_old
hasnt died on me yet

