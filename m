Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTKASZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 13:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTKASZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 13:25:34 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:64285 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263441AbTKASZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 13:25:33 -0500
Date: Sat, 1 Nov 2003 20:25:18 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide write cache issue? [Re: Something corrupts raid5 disks slightly during reboot]
Message-ID: <20031101182518.GL4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101082745.GF4640@niksula.cs.hut.fi> <20031101155604.GB530@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101155604.GB530@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 04:56:04PM +0100, you [Willy Tarreau] wrote:
> Hi Ville,
> 
> do you have the ability to reboot this beast on a DOS floppy equiped with a
> disk editor or even debug ? 

I have been planning (as someone else suggested) to boot to a different
kernel, but unfortunately I think my off-the-shelf solution, knoppix, won't
do as it probably includes raid autodetection in its kernel, and I'd rather
rule raidstart out as well.

Is there anything special in booting to DOS instead of different linux
kernel, other than that it would rule out some strange kernel bug that is
present in 2.2 and 2.4?

> BTW, it may even be your bios which believes for an unknown reason that it
> has to write to the partition table which is not one.

Yes, but I find it unlikely. The partition table in within the first 512
bytes and the corruption was in bytes 1060-1080. Also, one of the corrupted
disks is on i815 and another in on HPT370.

BTW: the corruption happens on warm reboots (running reboot command), not
just on power off / on.
 

-- v --

v@iki.fi
