Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137045AbREKE7S>; Fri, 11 May 2001 00:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137046AbREKE7I>; Fri, 11 May 2001 00:59:08 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:60422 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S137045AbREKE6z>; Fri, 11 May 2001 00:58:55 -0400
Message-Id: <200105110458.f4B4wnU82110@aslan.scsiguy.com>
To: Joachim Backes <backes@rhrk.uni-kl.de>
cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.4, Adaptec 7880 on board controller 
In-Reply-To: Your message of "Fri, 11 May 2001 06:42:01 +0200."
             <XFMail.20010511064201.backes@rhrk.uni-kl.de> 
Date: Thu, 10 May 2001 22:58:49 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>when booting on a machine having an Adaptec 7880 on board
>controller (Kernel 2.4.4), then i get the following msg:
>
>...
>...
>
>SCSI subsystem driver Revision: 1.00
>request_module[scsi_hostadapter]: Root fs not mounted
>request_module[scsi_hostadapter]: Root fs not mounted
>request_module[scsi_hostadapter]: Root fs not mounted

This was fixed post v6.1.5 of the aic7xxx driver.  You
can obtain patches for the latest version from here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin
