Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130475AbRBCXjz>; Sat, 3 Feb 2001 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130581AbRBCXjp>; Sat, 3 Feb 2001 18:39:45 -0500
Received: from pilsener.srv.ualberta.ca ([129.128.5.19]:26250 "EHLO
	pilsener.srv.ualberta.ca") by vger.kernel.org with ESMTP
	id <S130475AbRBCXjg>; Sat, 3 Feb 2001 18:39:36 -0500
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF6838FD@mailsrv.linkvest.ch>
Cc: linux-kernel@vger.kernel.org
Subject: RAID autodetect and 2.4.1
From: Chris <cb@speedbump.ucs.ualberta.ca>
Date: 03 Feb 2001 16:39:25 -0700
Message-ID: <50zog38hg2.fsf@speedbump.ucs.ualberta.ca>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I have a server with RAID1 partitions with linux 2.4.1 (stock,
> self-compiled) installed.  It was easy to create the RAID partitions
> but when booting, no auto-detection is successful.  The kernel says
> that autodetect is running, then done, but nothing is auto-detected.
> My devices are IDE devices (hda + hdc) and all drivers are bult-ins
> (no initrd nor modules).  After the boot, making a raidstart works
> like a charm...
> 
> Any advice?
> Help welcomed.

Sounds like you didn't set the partition type to be "FD" which is what
the raid autodetect looks for.  (Read the Software-RAID howto).  I
did the same thing yesterday. :)

-- 
Chris Bayly

Email:  Chris.Bayly@UAlberta.CA         | CNS, UNIX Support
                                        | 151 General Services Building
                                        | University of Alberta
Web:    http://www.ualberta.ca/~cbayly/ | Edmonton, Alberta 
                                        | Canada T6G 2S7
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
