Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRB0V1I>; Tue, 27 Feb 2001 16:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129574AbRB0V0t>; Tue, 27 Feb 2001 16:26:49 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:11528 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S129563AbRB0V0l>;
	Tue, 27 Feb 2001 16:26:41 -0500
Message-ID: <3A9C1B59.2492E5C9@kasey.umkc.edu>
Date: Tue, 27 Feb 2001 15:25:45 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: another Linux-2.4.2 splat: *** target pattern contains no `%'.  Stop.
In-Reply-To: <Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[david@nicol1 linux]$ make dep

make[3]: Entering directory `/mnt/sdb2/src/linux-2.4.2/drivers'
make -C acpi fastdep
make[4]: Entering directory `/mnt/sdb2/src/linux-2.4.2/drivers/acpi'
Makefile:29: *** target pattern contains no `%'.  Stop.
make[4]: Leaving directory `/mnt/sdb2/src/linux-2.4.2/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/mnt/sdb2/src/linux-2.4.2/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/mnt/sdb2/src/linux-2.4.2/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/mnt/sdb2/src/linux-2.4.2'
make: *** [dep-files] Error 2

