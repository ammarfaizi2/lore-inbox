Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRJaII2>; Wed, 31 Oct 2001 03:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280105AbRJaIIS>; Wed, 31 Oct 2001 03:08:18 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:19987 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S280104AbRJaIIE>; Wed, 31 Oct 2001 03:08:04 -0500
From: Norbert Preining <preining@logic.at>
Date: Wed, 31 Oct 2001 09:08:35 +0100
To: linux-kernel@vger.kernel.org
Subject: dead dvd drive or linux problem?
Message-ID: <20011031090835.A10181@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get the following errors while reading from cdrom:

Oct 31 08:35:25 mandala kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
Oct 31 08:35:25 mandala kernel: hdc: command error: error=0x51
Oct 31 08:35:25 mandala kernel: end_request: I/O error, cmd 0 dev 16:00 (hdc), sector 483216

The CD I tried to read is ok because in hdd=scd0(ide-scsi)=cdwriter it works.

Strange enough other CDs could be dd-ed without problems.

And yes, CONFIG_IDEDISK_MULTI_MODE=y

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
SKELLOW (adj.)

Descriptive of the satisfaction experienced when looking at a really
good dry-stone wall.

			--- Douglas Adams, The Meaning of Liff 
