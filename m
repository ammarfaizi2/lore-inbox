Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314264AbSEFHik>; Mon, 6 May 2002 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314260AbSEFHij>; Mon, 6 May 2002 03:38:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:35596 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314244AbSEFHij>;
	Mon, 6 May 2002 03:38:39 -0400
Date: Sun, 5 May 2002 23:34:16 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Christian Koenig <ChristianK.@t-online.de>, linux-kernel@vger.kernel.org,
        hpa@transmeta.com
Subject: Re: [PATCH] initramfs
Message-ID: <20020506063416.GE1199@kroah.com>
In-Reply-To: <1744hw-0EYlYuC@fwd01.sul.t-online.com> <Pine.GSO.4.21.0205041509300.23892-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 08 Apr 2002 04:45:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 03:14:51PM -0400, Alexander Viro wrote:
>  
> Anyway, the real problem with iniramfs is on the build side.  I.e. what
> do we want in makefiles for early userland/what do we want to use as
> libc?

I have the start of a libc, based on your original "libc" in your
original initramfs patches, merged with some of my initial klibc 0.1
work <kernel.org/pub/linux/kernel/people/gregkh/klibc/> which was based
off of dietLibc.

It's available at http://linuxusb.bkbits.net:8080/klibc if people want
to poke around with it.  I'll dust it off this week, and post a clean
tarball, as it's been on hold.

Actually, in looking at that archive, it doesn't seem to have the latest
stuff checked in...I'll go find it in the morning...

I too am interested in how the makefiles and build process will work :)

thanks,

greg k-h
