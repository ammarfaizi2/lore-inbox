Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131274AbRBFByE>; Mon, 5 Feb 2001 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136111AbRBFBxy>; Mon, 5 Feb 2001 20:53:54 -0500
Received: from beaker.bluetopia.net ([63.219.235.110]:44624 "EHLO
	beaker.bluetopia.net") by vger.kernel.org with ESMTP
	id <S131274AbRBFBxk>; Mon, 5 Feb 2001 20:53:40 -0500
Date: Mon, 5 Feb 2001 20:53:18 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
In-Reply-To: <Pine.LNX.4.04.10102051856530.2712-100000@beaker.bluetopia.net>
Message-ID: <Pine.LNX.4.04.10102052049070.2712-100000@beaker.bluetopia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Ricky Beam wrote:
>Interesting...  I just checked my machine (2.4.1-SMP) to see it only saw
>64MB when it has 256MB.
...
>Nothing at all has changed in either the BIOS setup, compiler, etc.  All I
>did was reboot (and not pay it any attention.)  The configuration was the
>same (make oldconfig.)

Dammit.  Ok, all better now.  I guess that fruit fly managed to get into
more than just the slot-1 connector.  We can thank Tyan and AMI for not
checking the contents of ESCD nor giving me a way to reset it without
nuking CMOS.

(It would appear ACPI, when re-enabled, powered the RAID controller down.
 That makes it Really Hard (tm) to boot.)

--Ricky


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
