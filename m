Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSDIUv7>; Tue, 9 Apr 2002 16:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311572AbSDIUv6>; Tue, 9 Apr 2002 16:51:58 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:16649 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311564AbSDIUvz>; Tue, 9 Apr 2002 16:51:55 -0400
Message-ID: <3CB345E4.16CE5C9C@zip.com.au>
Date: Tue, 09 Apr 2002 12:49:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geoffrey Gallaway wrote:
> 
> ...
> Originally I started playing with ram disks but when I try to create a new
> ramdisk with "mke2fs /dev/ram0 16384" mke2fs says:
> mke2fs: Filesystem larger then apparent filesystem size.
> Proceed anyway? (y,n) y
> Warning: could not erase sector 2: Invalid arguement
> Warning: could not erase sector 0: Attempt to write block from filesystem
> resulted in short write
> mke2fs: Invalid arguement zeroing block 16320 at end of filesystem

Try omitting the `16384' option - let mke2fs work out the
size.
