Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbRAXRDw>; Wed, 24 Jan 2001 12:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAXRDm>; Wed, 24 Jan 2001 12:03:42 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:45303 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129710AbRAXRDb>; Wed, 24 Jan 2001 12:03:31 -0500
Date: Wed, 24 Jan 2001 11:03:30 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010124162842.00a48720@pop.cus.cam.ac.uk>
In-Reply-To: <E14LOAm-0006z0-00@the-village.bc.nu> <E14LOAm-0006z0-00@the-village.bc.nu> 
	<01012416081105.19999@nessie>
Subject: Re: NTFS safety and lack thereof - Was: Re: Linux 2.4.0ac11
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010124170337Z129710-18594+930@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Anton Altaparmakov <aia21@cam.ac.uk> on Wed, 24 Jan
2001 16:54:36 +0000


> >Is read access safe ?
> 
> Of course read-only is safe. As long as you mount the partition READ-ONLY 
> nothing can happen to it in any way, your NTFS data is at least safe.

Isn't it still theoretcially possible for the driver to send commands to the
disk controller that cause data to become overwritten, even when it's just
supposed to read that data?


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
