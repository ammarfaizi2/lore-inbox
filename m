Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBAB0m>; Wed, 31 Jan 2001 20:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbRBAB0c>; Wed, 31 Jan 2001 20:26:32 -0500
Received: from fly.HiWAAY.net ([208.147.154.56]:4877 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S129232AbRBAB0W>;
	Wed, 31 Jan 2001 20:26:22 -0500
Date: Wed, 31 Jan 2001 19:26:21 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
Message-ID: <20010131192621.B9494@HiWAAY.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: HiWAAY Information Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, David Ford  <david@linux.com> said:
>The largest bodies of text come from scsi, irda, usb, and udf.

Don't forget software RAID.  You get gobs of output from autodetect and
startup of each filesystem (so if you have 6 or so RAID filesystems, you
can get over 13kB of messages).
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
