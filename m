Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAPUQs>; Tue, 16 Jan 2001 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAPUQj>; Tue, 16 Jan 2001 15:16:39 -0500
Received: from [199.26.153.10] ([199.26.153.10]:63493 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S129511AbRAPUQ1>;
	Tue, 16 Jan 2001 15:16:27 -0500
Message-ID: <3A64ABB7.FB3D1FB9@fourelle.com>
Date: Tue, 16 Jan 2001 12:14:47 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Failure to mount INITRD on a 1GB or 2GB machine w/ 4GB bigmem enabled. 
 (2.4.0)]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the 2.4.0 kernel and a kernel compiled with support for 4GB of
memory, mounting of the initial ramdisk fails when 1GB or more
of memory is installe dint he system.
There is no OOPS, it simply says, unable to mount root vfs, I ma
thinking the INITRD system cant handle the offset's involved in a big
mem machine, I have not worked with the vfs or init code before,
otherwise I would attempt to fix it myself.

I would appreicate any help I can get with this problem, this is the
second time I have reported it and I am responsible for getting it to
work ;)

-Adam


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
