Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136163AbRA1QBH>; Sun, 28 Jan 2001 11:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137083AbRA1QA6>; Sun, 28 Jan 2001 11:00:58 -0500
Received: from gear.torque.net ([204.138.244.1]:10245 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S136163AbRA1QAm>;
	Sun, 28 Jan 2001 11:00:42 -0500
Message-ID: <3A744120.513217E@torque.net>
Date: Sun, 28 Jan 2001 10:56:16 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfsd, compiling on glibc22x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While on the subject of devfs:
  - it doesn't seem to have any entries for raw devices:
    /dev/rawctl, /dev/raw/raw1, etc
  - when I upgraded to glibc 2.2 (via a rpm) in RH 7.0
    this line in /etc/devfsd.conf caused devfsd to 
    seg fault:
    "LOOKUP      ^cdrom$      CFUNCTION      GLOBAL     
         symlink ${mntpnt}/cdroms/cdrom0 $devpath"
    Rebuilding devfsd didn't help.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
