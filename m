Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268001AbRHBA0G>; Wed, 1 Aug 2001 20:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268021AbRHBAZ4>; Wed, 1 Aug 2001 20:25:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53772 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268001AbRHBAZq>; Wed, 1 Aug 2001 20:25:46 -0400
Subject: Re: 3ware Escalade problems
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Thu, 2 Aug 2001 01:26:22 +0100 (BST)
Cc: ransom@cfa.harvard.edu (Scott Ransom), linux-kernel@vger.kernel.org
In-Reply-To: <20010801143935.A21157@vger.timpanogas.org> from "Jeff V. Merkey" at Aug 01, 2001 02:39:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15S6Ji-00085T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am also using 8 way escalade adapters, and am seeing a host of problems.

I've seen no problems since the 1.02.00.005 driver. 

> The first and foremore is that the gendisk head in 2.4.X is not being 
> initialized properly in the driver.  I have reported these problems to

The gendisk comes from the scsi midlayer so you want linux-scsi for that

