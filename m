Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbSL1SLG>; Sat, 28 Dec 2002 13:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbSL1SLG>; Sat, 28 Dec 2002 13:11:06 -0500
Received: from host194.steeleye.com ([66.206.164.34]:51984 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266256AbSL1SLG>; Sat, 28 Dec 2002 13:11:06 -0500
Message-Id: <200212281819.gBSIJJ202919@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from Russell King <rmk@arm.linux.org.uk> 
   of "Sat, 28 Dec 2002 18:14:38 GMT." <20021228181438.B5217@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Dec 2002 12:19:19 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmk@arm.linux.org.uk said:
> What happens to &hwdev->dev when you do as detailed there and pass
> NULL into these "compatibility" functions?  Probably an oops. 

Yes.  Already found by Udo Steinberg and fixed in bk latest...

James


