Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281546AbRLAKIw>; Sat, 1 Dec 2001 05:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281537AbRLAKIm>; Sat, 1 Dec 2001 05:08:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3200 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281527AbRLAKI0>; Sat, 1 Dec 2001 05:08:26 -0500
Date: Sat, 1 Dec 2001 03:12:43 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: EXT2 data corruption 2.4.17-pre2
Message-ID: <20011201031243.B2412@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Al Viro,

I am seeing subtle data corruption of inode data blocks on ext2 
with 2.4.17-pre1/2.  Large files being untarred over and over 
and over again seem to trigger it, but it's hard to reproduce.  
(i.e. I am building patches against several kernel trees).  

I have gotten it to happen twice.  In both cases, I get a CRC 
error in a tar.gz and a message "skipping to next tar header"
furing this error.  The data is totally corrupted in the tar.gz
when this problem shows up.  It takes **HOURS** of heavy 
untarring/diffing/untarring to make it show up.

Jeff

