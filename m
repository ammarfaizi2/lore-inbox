Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbRDWSPb>; Mon, 23 Apr 2001 14:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135494AbRDWSPV>; Mon, 23 Apr 2001 14:15:21 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:57615 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S135491AbRDWSPH>; Mon, 23 Apr 2001 14:15:07 -0400
Date: Mon, 23 Apr 2001 12:08:52 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 3-Ware Raid driver fails to update GenDisk head
Message-ID: <20010423120852.A32097@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andre/LKML,

I am still working on this, but would appreciate some help from
whomever owns this driver proper.  I have discovered that the 
3Ware drivers are not updating the gendisk_head with devices
reported and exposed to user space as /dev/sda, sdb, etc.  The 
adapter driver does correctly report devices to user space, but 
is not properly reflecting these devices in the gendisk_head,
which makes it rather hard for kernel level drivers to scan 
and determine which devices are attached to the controller.

I attempted to correct this in the code, but found that these
changes are a very significant effort to get working.  

Please advise.

Jeff

