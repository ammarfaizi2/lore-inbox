Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267080AbSLDUsF>; Wed, 4 Dec 2002 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbSLDUsF>; Wed, 4 Dec 2002 15:48:05 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33517 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267080AbSLDUsF>; Wed, 4 Dec 2002 15:48:05 -0500
Date: Wed, 4 Dec 2002 21:55:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jim Van Zandt <jrv@vanzandt.mv.com>
Cc: device@lanana.org, linux-kernel@vger.kernel.org
Subject: Why does the Comtrol Rocketport card not have a major assigned?
Message-ID: <20021204205525.GE2544@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps it's a silly question but I'd like to know why it is the way it 
is:

The 2.2, 2.4 and 2.5 kernels include a driver for the Comtrol Rocketport 
card (drivers/char/dtlk.c) which uses a local major (it does a
  "register_chrdev(0, "dtlk", &dtlk_fops);
). Is there a reason why it doesn't have a fixed major assigned?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

