Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSGBJkx>; Tue, 2 Jul 2002 05:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSGBJkw>; Tue, 2 Jul 2002 05:40:52 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:57497 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316684AbSGBJkv>; Tue, 2 Jul 2002 05:40:51 -0400
Date: Tue, 2 Jul 2002 11:12:03 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
In-Reply-To: <3D216157.FC60B17E@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0207021111050.21320-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002, Helge Hafting wrote:

> > > /dev/md1                swap                    swap    defaults        0 0
> > 
> > One small thing, you do know that you can interleave swap?
> 
> There are sometimes reasons not to do that.
> Heavy swapping may be caused by attempts to cache 
> massive io on some fs.  You better not have swap
> on that heavily accessed spindle - because then
> everything ends up waiting on that io.
> 
> Keeping swap somewhere else means other programs
> just wait a little for swap - undisturbed by the massive
> io also going on.

True, but what i meant was that instead of creating a RAID device to swap 
to, he could have just interleaved normal swap partitions and gotten the 
same effect.

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

