Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBAGII>; Thu, 1 Feb 2001 01:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129457AbRBAGH6>; Thu, 1 Feb 2001 01:07:58 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:12306 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129181AbRBAGHx>;
	Thu, 1 Feb 2001 01:07:53 -0500
Message-ID: <3A78FDD6.6010803@megapathdsl.net>
Date: Wed, 31 Jan 2001 22:10:30 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i686; en-US; m18) Gecko/20010130
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: mount/umount doesn't track used resources correctly?
In-Reply-To: <3A6CBE53.8050400@megapathdsl.net> <m3elxvnouk.fsf@austin.jhcloos.com> <3A733E33.BEC2174E@cern.ch> <3A73F372.DAA5DFCD@snowbird.megapath.net> <3A73FB0E.DB64D0C0@cern.ch> <m34ryjqefn.fsf@austin.jhcloos.com> <3A750DC4.2ACB4A9F@snowbird.megapath.net> <3A7530A0.8F3D6AEA@cern.ch> <3A77431E.9010605@megapathdsl.net> <3A776890.53BAFBCD@megapath.net> <20010131005936.E18746@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Woohoo!  Thanks Peter.

You are correct.  I just built and installed util-linux-2.10s
from source.  I ran through the cross-mounting scenario
and was able to unmount all the partitions on the USB
external drive and then unload all the USB drivers.

Perhaps util-linux-2.10s should be made the new default
listed in Documentation/Changes?

Cheers,
	Miles

Peter Samuelson wrote:

> [Miles Lane]
> 
>> I think the problem may be due to usermode tools not handling the new
>> "mount multiple devices to a single mount point" feature, but I'm not
>> sure.
> 
> Yes, quite possibly.  Rumor has it that util-linux has recently
> acquired some wisdom in this area.  (I can't confirm or deny.)  Try
> upgrading, or just trust /proc/mounts for the real story..
[...]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
