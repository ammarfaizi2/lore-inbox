Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSEVMOt>; Wed, 22 May 2002 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEVMOs>; Wed, 22 May 2002 08:14:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60177 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312601AbSEVMOr>; Wed, 22 May 2002 08:14:47 -0400
Date: Wed, 22 May 2002 13:14:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: jack@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
Message-ID: <20020522131441.C16934@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB78D7.7070107@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:54:15PM +0200, Martin Dalecki wrote:
> Please put the following crap under /proc/sys/fs,
> where it belongs. OK?

/proc/sys is for sysctls, not random proc junk.  Therefore, putting the
random crap you point out that's currently in /proc/fs in /proc/sys/fs:

> [root@kozaczek fs]# pwd
> /proc/fs
> [root@kozaczek fs]# cat quota
> Version 60501
> Formats
> 0 0 0 0 0 0 0 8
> [root@kozaczek fs]#

is even worse.

/proc/sys has a clean and clear purpose.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

