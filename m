Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132833AbRDPBd2>; Sun, 15 Apr 2001 21:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132825AbRDPBdI>; Sun, 15 Apr 2001 21:33:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:43537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132826AbRDPBdD>; Sun, 15 Apr 2001 21:33:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Can't free the ramdisk (initrd, pivot_root)
Date: 15 Apr 2001 18:32:45 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bdi3t$th3$1@cesium.transmeta.com>
In-Reply-To: <3ADA0B50.8030301@muppetlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3ADA0B50.8030301@muppetlabs.com>
By author:    Amit D Chaudhary <amit@muppetlabs.com>
In newsgroup: linux.dev.kernel
> 
> On the same topic, I have not found any change in free memory
> reported before and after the ioctl call. Though umount /initrd does
> free around 2 MB.
> 

With Scott's patch applied, I get substantially better performance on
low-memory machines, so I'm guessing it's doing its job.  Also, just
umount /initrd for me made it still possible to mount it, so it
clearly did not go away.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
