Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbREQBff>; Wed, 16 May 2001 21:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbREQBfZ>; Wed, 16 May 2001 21:35:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35044 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262166AbREQBfM>;
	Wed, 16 May 2001 21:35:12 -0400
Message-ID: <3B032ACD.E1998F82@mandrakesoft.com>
Date: Wed, 16 May 2001 21:35:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105161822.f4GIMo509185@vindaloo.ras.ucalgary.ca>
		<E150B5B-0004fs-00@the-village.bc.nu> <200105162358.f4GNwll13400@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To inject a bit of concrete into this discussion, I note that block
devices with dynamically assigned don't work with CONFIG_DEVFS and
devfs=only.  Block devices -require- majors currently, due to those
!@#!@# arrays.  However, devfs_register_blkdev always returns zero when
devfs=only, even if its a block device and a dynamic major is requested.
-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
