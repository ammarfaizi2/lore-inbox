Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBVHCb>; Thu, 22 Feb 2001 02:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBVHCU>; Thu, 22 Feb 2001 02:02:20 -0500
Received: from viper.haque.net ([64.0.249.226]:3968 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S129134AbRBVHCR>;
	Thu, 22 Feb 2001 02:02:17 -0500
Date: Thu, 22 Feb 2001 02:02:16 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: EXT2-fs error
Message-ID: <Pine.LNX.4.32.0102220159390.1925-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following after compiling/rebooting into 2.4.2 and forcing a
fsck.

EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
#508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
name_len=0
EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
#508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
name_len=0

Possibly the result of the 'silent' bug in 2.4.1?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================


