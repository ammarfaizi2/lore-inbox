Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLOPqF>; Fri, 15 Dec 2000 10:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbQLOPpv>; Fri, 15 Dec 2000 10:45:51 -0500
Received: from 24-216-78-5.hsacorp.net ([24.216.78.5]:49669 "EHLO
	mccoy.penguinpowered.com") by vger.kernel.org with ESMTP
	id <S129387AbQLOPp3>; Fri, 15 Dec 2000 10:45:29 -0500
From: Jens Petersohn <jkp@mccoy.penguinpowered.com>
Message-Id: <200012151514.JAA29931@mccoy.penguinpowered.com>
Subject: [Q] Remote serial ports?
To: linux-kernel@vger.kernel.org
Date: Fri, 15 Dec 2000 09:14:57 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have an application in which it would be useful to have access to
remote serial ports as if they where local ports. 

Machine A has several serial ports on it connected to various
special types of devices in a locked machine room.

Developers on workstation B wants to execute an application that
communicates with the special devices, but can only do so via
/dev/ttySXX. The developer however (for various reasons) cannot
directly log into Machine A.

Is there some software that would allow "remote forwarding" of
serial ports? I.e. a driver that emulates a serial port on
machine B and forwards the read/write/ioctl operations to machine A?
Does this exist? Is it possible to implement if it doesn't?
Am I overlooking something obvious?

Thank you in advance,

Jens Petersohn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
