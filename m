Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281664AbRKQAwo>; Fri, 16 Nov 2001 19:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281665AbRKQAwf>; Fri, 16 Nov 2001 19:52:35 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:62439 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S281664AbRKQAwR>; Fri, 16 Nov 2001 19:52:17 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D76A@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Keith Owens'" <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org
Subject: RE: 2.4.15-pre5 conflict between acpi and a.out, affs is implicat
	ed
Date: Fri, 16 Nov 2001 16:52:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Keith Owens [mailto:kaos@ocs.com.au]
> include/asm-*/a.out.h defines STACK_TOP.  So does
> drivers/acpi/include/acinterp.h, with a different value.  The conflict
> occurs if you compile with acpi and a.out, or with acpi and affs.  For
> reasons that are beyond me, include/linux/affs_fs_i.h 
> contains #include
> <linux/a.out.h>.
> 
> ACPI needs to use a different name.

Deleted.

The next ACPI release will include this fix.

Regards -- Andy
