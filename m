Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131999AbRAPUTI>; Tue, 16 Jan 2001 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131940AbRAPUS6>; Tue, 16 Jan 2001 15:18:58 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:9221 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S131929AbRAPUSs>; Tue, 16 Jan 2001 15:18:48 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95198@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Dr. Kelsey Hudson'" <kernel@blackhole.compendium-tech.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 15:14:22 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you're forgetting that in /etc/lilo.conf there is a directive called
> 'append='... all the user has to do is merely add
> 'append="scsihosts=whatever,whatever"' into their config file and rerun
> lilo. problem solved
> 
> besides, how many 'end-users' do you know of that will have multiple scsi
> adapters in one system? how many end-users -period- will have even a
> *single* scsi adapter in their systems? do we need to bloat the kernel
> with automatic things like this? no... i think it is handled fine the way
> it is. if the user wants to add more than one scsi adapter into his
> system, let him read some documentation on how to do so. (is this even a
> documented feature? if not, i think it should be added to the docs...)
	[Venkatesh Ramamurthy]  Dont you think that mounting and booting
based on disk label names is better, then relying on device nodes which can
change when a new card is added?. The existing patch for 2.2.xx is quite
small and it does not bloat the kernel too much either. I think we can port
it for 2.4.XX with ease.In my words it is worth the effort 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
