Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRAKSwZ>; Thu, 11 Jan 2001 13:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132495AbRAKSwG>; Thu, 11 Jan 2001 13:52:06 -0500
Received: from [199.26.153.10] ([199.26.153.10]:36363 "EHLO fourelle.com")
	by vger.kernel.org with ESMTP id <S132106AbRAKSwC>;
	Thu, 11 Jan 2001 13:52:02 -0500
Message-ID: <3A5E007A.34084DA5@fourelle.com>
Date: Thu, 11 Jan 2001 10:50:35 -0800
From: Adam Scislowicz <adams@fourelle.com>
Organization: Fourelle Systems, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 on a bigmemory machine (2GB) with ramdisk+initrd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: When booting 2.4.0 on x86 with 2GB of memory, the initial
ramdisk fails to mount. The initial ramdisk is 48MB.

Debugging so far: I can increment and decrement the memory in 512MB
intervals. The initial ramdisk does mount with 512MB of
memory installed, but does not with 1GB+ of memory installed.

I would appreciate any help I can get on this, thanks in advance.

 -Adam Scislowicz <adams@fourelle.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
