Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVCPSrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVCPSrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVCPSrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:47:15 -0500
Received: from host218-153.pool80183.interbusiness.it ([80.183.153.218]:29198
	"HELO gg.mine.nu") by vger.kernel.org with SMTP id S262747AbVCPSp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:45:28 -0500
Message-ID: <20050316184523.30672.qmail@gg.mine.nu>
References: <20050312160704.22527.qmail@gg.mine.nu>
            <4233254F.3000509@roarinelk.homelinux.net>
In-Reply-To: <4233254F.3000509@roarinelk.homelinux.net> 
From: "Guido Villa" <piribillo@yahoo.it>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error with Sil3112A SATA controller and Maxtor 300GB HDD
Date: Wed, 16 Mar 2005 19:45:23 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss writes: 

> I happen to have a SiI 3112A controller and a Maxtor 6B300S0 attached to
> it, formatted with ext2. Never had any problems. I just copied
> 200GB of data to it, worked flawlessly. (Vanilla 2.6.11)
> Maybe its the Motherboard?

Hi Manuel, 

I was checking my kernel configuration, and some doubts arised in my mind. 
Would you please check if my parameters are the same as yours? 

set:
CONFIG_IDE_GENERIC
CONFIG_BLK_DEV_IDEPCI
CONFIG_SCSI
CONFIG_BLK_DEV_SD
CONFIG_SCSI_SATA
CONFIG_SCSI_SATA_SIL 

unset:
CONFIG_BLK_DEV_GENERIC
CONFIG_BLK_DEV_SIIMAGE (I'm unsure on this) 

Is that right? 

Thank you.
Bye,
Guido 

