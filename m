Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSHGWDE>; Wed, 7 Aug 2002 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHGWDE>; Wed, 7 Aug 2002 18:03:04 -0400
Received: from waste.org ([209.173.204.2]:28390 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313571AbSHGWDD>;
	Wed, 7 Aug 2002 18:03:03 -0400
Date: Wed, 7 Aug 2002 17:06:37 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Eli Carter <eli.carter@inet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Idle curiosity: Acting as a SCSI target
In-Reply-To: <3D519357.7070904@inet.com>
Message-ID: <Pine.LNX.4.44.0208071659090.16458-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Eli Carter wrote:

> Based on a conversation I had recently, my curiosity got piqued...
>
> I'm not really sure how to query google on this, and didn't turn up what
> I was looking for because of that, so here's the random question:
>
> Is there a way to make a Linux machine with a scsi controller act like a
> scsi device (is the correct term 'target'?) (such as a disk) using a
> local block device as storage?

No, not in the stock kernel.

However, if you look up stuff having to do with IP over SCSI (old) or SCSI
over IP (new), you will find quite a number of the pieces needed for this.

> I'm not sure it would be of general use, but I can see uses in weird or
> remote prototyping situations...

You're not thinking hard enough. Try this: embedded Linux taking whatever
form or number of disks together with software RAID _and_ volume
management / snapshot capability and whatever other intelligence you want
and presenting it to hosts as an arbitrary number of generic SCSI / FC /
iSCSI disks.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

