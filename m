Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDNVdQ>; Sat, 14 Apr 2001 17:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDNVdG>; Sat, 14 Apr 2001 17:33:06 -0400
Received: from relay.freedom.net ([207.107.115.209]:51973 "HELO relay")
	by vger.kernel.org with SMTP id <S132548AbRDNVc4>;
	Sat, 14 Apr 2001 17:32:56 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQG8gRvdjd1iNZJ6E/U5d1D4kkBQdBN7xSLdwUr9CPGE2ryUkiHkPL+L
Date: Sat, 14 Apr 2001 15:31:42 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Writing to Pana DVD-RAM
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010414213259Z132548-682+222@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running RedHat Wolverine (beta) with kernel 2.4.2.  I have a SCSI subsystem (AHA2740) with a Panasonic LF-D101 DVDRAM on it.

I read that the CDROM driver is built to recognize DVDRAMs and allow writes; well I can mount and read the UDF file system fine, but am not allowed writes.  I have UDF2.0 on the disk, because it didn't recognize UDF2.1.

Also, when I  make xconfig,  it includes UDF support, but read-only. (Write-Experimental is grayed-out)

In fstab: /dev/scd1 is mounted to /mnt/dvdram  udf  default 0 0. (paraphrasing)

I need the DVDRAM for backups and file transfers.  Is the problem the driver, the UDF filesystem, my setup, or what?
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


