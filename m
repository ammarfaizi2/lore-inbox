Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHTVrI>; Mon, 20 Aug 2001 17:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269506AbRHTVqd>; Mon, 20 Aug 2001 17:46:33 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:26378 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269540AbRHTVpn>; Mon, 20 Aug 2001 17:45:43 -0400
Message-Id: <200108202145.f7KLjsY43284@aslan.scsiguy.com>
To: Cliff Albert <cliff@oisec.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo 
In-Reply-To: Your message of "Mon, 20 Aug 2001 23:09:10 +0200."
             <20010820230909.A28422@oisec.net> 
Date: Mon, 20 Aug 2001 15:45:54 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And here they are, the dmesg is my bootup dmesg with the devices drivers 
>> and stuff, and the second dmesg is the actual errors (verbose turned on)
>
>Some more research pointed out that the errors/lock of the scsi bus always 
>appears about 20 seconds after kernel load when i cold boot the machine. 
>With a warm boot the machine gives these errors/lock at random times.

IIRC, the problem has to do with the state of the write cache in the drive.
The cache will be in a different state after power-on as compared to
after some amount of activity.

--
Justin
