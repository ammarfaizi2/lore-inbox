Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRB0ALD>; Mon, 26 Feb 2001 19:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRB0AKx>; Mon, 26 Feb 2001 19:10:53 -0500
Received: from customer-VER-208-19.megared.net.mx ([200.52.208.19]:9487 "EHLO
	bsd.ver.megared.net.mx") by vger.kernel.org with ESMTP
	id <S129289AbRB0AKp>; Mon, 26 Feb 2001 19:10:45 -0500
Date: Mon, 26 Feb 2001 18:10:09 -0600
From: MC_Vai <estoy@ver.megared.net.mx>
To: linux-kernel@vger.kernel.org
Subject: Massive Corruption
Message-ID: <20010226181009.B25911@lapurapus.ver.megared.net.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi,
	I have a problem with my filesystem, the kernel panics
	as soon as it tries to mount the root filesystem.

	I guess it is because of the IDE bug in the driver
	Russell found, but he (Russell) suggest me to post
	my message here.

	What I've tried up to now:
	~~~~~~~~~~~~~~~~~~~~~~~~~
	% e2fsck -B 4096 /dev/<part>
	% e2fsck -B 8192 /dev/<part>
	... (16384, 32768, etc.)

	% e2fsck -b 4097 /dev/<part>
	% e2fsck -b 8193 /dev/<part>
	... (16385, 32769, etc.)

	The error message I got:
	(no matter the argument)
	~~~~~~~~~~~~~~~~~~~~~~~~~
e2fsck 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
e2fsck: Bad magic number in super-block while trying to open /dev/hda6

	My (formerly) system:
	~~~~~~~~~~~~~~~~~~~~~~~~~
	o   Kernel Version:  2.4.0
	o   Hard Disk:       IBM DTTA-351010 (mode=AUTO in the BIOS)
	o   Architechture:   i386


	Is there anything I can do in order to recover my
	corrupted partition?
	Am I doing something wrong?

	Thanks a lot in advance.
	Regards,
	                                  Eduardo.
