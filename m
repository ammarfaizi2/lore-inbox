Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbREPSN1>; Wed, 16 May 2001 14:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261989AbREPSNR>; Wed, 16 May 2001 14:13:17 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:22283 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261288AbREPSNL>; Wed, 16 May 2001 14:13:11 -0400
Message-Id: <200105161812.f4GICXU70851@aslan.scsiguy.com>
To: Massimo Dal Zotto <dz@cs.unitn.it>
cc: alan@redhat.com, linux-kernel@vger.kernel.org, tmm@image.dk
Subject: Re: [PATCH] move aic7xxx ld in drivers/scsi/Makefile 
In-Reply-To: Your message of "Wed, 16 May 2001 14:05:16 +0200."
             <200105161205.OAA13638@nikita.dz.net> 
Date: Wed, 16 May 2001 12:12:33 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>while examining the makefiles of kernel-2.4.4 I noticed that the top Makefile
>contains a specific reference to the aic7xxx driver which should IMHO be
>referenced only by the drivers/scsi/Makefile.

This was changed post v6.1.5 of the aic7xxx driver.  Apply the latest
patch for 2.4.4 from here:

http://people.FreeBSD.org/~gibbs/linux/

and see if this is satisfactory.

--
Justin
