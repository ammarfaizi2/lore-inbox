Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbQLOU6m>; Fri, 15 Dec 2000 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131427AbQLOU6c>; Fri, 15 Dec 2000 15:58:32 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:18670 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S131139AbQLOU6Z>; Fri, 15 Dec 2000 15:58:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012152027.eBFKRmh07217@webber.adilger.net>
Subject: Re: [Q] Remote serial ports?
In-Reply-To: <200012151514.JAA29931@mccoy.penguinpowered.com>
 "from Jens Petersohn at Dec 15, 2000 09:14:57 am"
To: Jens Petersohn <jkp@mccoy.penguinpowered.com>
Date: Fri, 15 Dec 2000 13:27:48 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Petersohn writes:
> I have an application in which it would be useful to have access to
> remote serial ports as if they where local ports. 
> 
> Machine A has several serial ports on it connected to various
> special types of devices in a locked machine room.
> 
> Developers on workstation B wants to execute an application that
> communicates with the special devices, but can only do so via
> /dev/ttySXX. The developer however (for various reasons) cannot
> directly log into Machine A.
> 
> Is there some software that would allow "remote forwarding" of
> serial ports? I.e. a driver that emulates a serial port on
> machine B and forwards the read/write/ioctl operations to machine A?
> Does this exist? Is it possible to implement if it doesn't?
> Am I overlooking something obvious?

Please see the posting on l-k today "[NEW DRIVER] New user space serial port"
which does just what you want.  Just-in-time kernel development has arrived.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
