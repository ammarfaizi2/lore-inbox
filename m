Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTBLR0c>; Wed, 12 Feb 2003 12:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTBLR0c>; Wed, 12 Feb 2003 12:26:32 -0500
Received: from theta1.cft.edu.pl ([195.187.84.131]:52492 "EHLO
	theta1.cft.edu.pl") by vger.kernel.org with ESMTP
	id <S267254AbTBLR0b>; Wed, 12 Feb 2003 12:26:31 -0500
Date: Wed, 12 Feb 2003 18:35:39 +0100
From: Cezary Sliwa <sliwa@cft.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 problems with some multisession CD's and IDE chipsets
Message-ID: <20030212173538.GA21846@theta1.cft.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have found that 2.4.20 can't read some files from a multisession CD
(that was written with Adaptec DirectCD). I get

Feb 12 17:36:27 czarek kernel: end_request: I/O error, dev 03:40 (hdb), sector 1109136
Feb 12 17:36:27 czarek kernel: hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }

(linux 2.2.22 reads the same file with no trouble).

I have also found that 2.4 corrupts data with some older VIA 82C686
mainboard, unless it is booted with the ide0=serialize parameter or DMA is
off (again, 2.2 works fine).

Regards,
C.S.

