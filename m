Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282316AbRKXBHp>; Fri, 23 Nov 2001 20:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282321AbRKXBHe>; Fri, 23 Nov 2001 20:07:34 -0500
Received: from [212.18.232.186] ([212.18.232.186]:6918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282318AbRKXBHZ>; Fri, 23 Nov 2001 20:07:25 -0500
Date: Sat, 24 Nov 2001 01:07:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: ISP Client <summer@os2.ami.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXTRAVERSION =-greased-turkey
Message-ID: <20011124010705.G3141@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0111240858040.9212-100000@numbat.os2.ami.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111240858040.9212-100000@numbat.os2.ami.com.au>; from summer@os2.ami.com.au on Sat, Nov 24, 2001 at 08:59:37AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 08:59:37AM +0800, ISP Client wrote:
> Now, can we return to leaving that for the user/vendor in future releases?

I'd suggest reading a linux-kernel or an archive site, and pulling Al Viro's
2nd patch for 2.4.15 inode.c problems.

2.4.15 has the potential to corrupt your filesystems slightly on reboot.
Al provides a safe method to reboot without this corruption, but it will
still be a good idea to force a fsck on boot, using:

	shutdown -F -r now

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

