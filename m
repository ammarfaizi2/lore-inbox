Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282155AbRKWOkD>; Fri, 23 Nov 2001 09:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282158AbRKWOjx>; Fri, 23 Nov 2001 09:39:53 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:40527 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282155AbRKWOjt>; Fri, 23 Nov 2001 09:39:49 -0500
Date: Fri, 23 Nov 2001 16:39:32 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: HPT370 on 2.2.20+ide-patch - or is it RAID?
Message-ID: <20011123163932.E4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi> <20011122215424.C4809@niksula.cs.hut.fi> <20011123143502.D4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123143502.D4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Nov 23, 2001 at 02:35:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 02:35:02PM +0200, you [Ville Herva] claimed:
> On Thu, Nov 22, 2001 at 09:54:24PM +0200, you [Ville Herva] claimed:
> 
> I'm trying again with 2.2.20/IDE 05042001/no hpt patch/slightly older
> bios/UDMA33 instead of UDMA66. (Just _too_ many variables... Phew.)

2.2.20/IDE 05042001/no hpt patch/UDM33 gives no IDE errors, but
/dev/md0 md5sums still differ.

Since I didn't see the corruption with /dev/hde nor /dev/hdg, I'm beginning
to wonder if this is in fact RAID/VM/some other problem...?

2.2.19 included the VM rewrite, and I also patched the 2.2.20 kernel with
Andrea's VM-locked-1 -patch (which I figure shouldn't really affect read
path?)

The 2.2.18pre19 kernel (that works) uses 2.2.17-raid A0-patch, and
2.2.20 uses 2.2.19-A1. The differences between the two seems trivial.

I would be delighted if someone could confirm that 2.2.20+raid-A1 works 100%
correct... Just md5summing the contents of /dev/md0 3-4 times should do if
were lucky. It takes time, though...

 
-- v --

v@iki.fi
