Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272296AbRHXSnJ>; Fri, 24 Aug 2001 14:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272297AbRHXSm7>; Fri, 24 Aug 2001 14:42:59 -0400
Received: from [209.10.41.242] ([209.10.41.242]:65510 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272296AbRHXSmw>;
	Fri, 24 Aug 2001 14:42:52 -0400
Date: Fri, 24 Aug 2001 20:37:42 +0200
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, announce@x86-64.org, linux-kernel@vger.kernel.org
Subject: 2.4.9 based x86-64 kernel snapshot released.
Message-ID: <20010824203742.A4931@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new x86_64 linux kernel snapshot is available. 

Changes against the previous snapshot:
- Now based on linux 2.4.9
- Some files merged with the i386 port.
- ACPI is enabled again
- Many driver fixes
- A floating signal stack frame bug in the i386 emulation has been fixed.
- Some bug fixes to the i386 emulation
- Some minor cleanups.

Caveats: 
- SMP currently still non functional

Tar file with the complete tree: 

ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/linux-x86_64-2.4.9-1.tar.bz2

Patch file against official Linux 2.4.9:

ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/x86_64-2.4.9-1.bz2

Compiling it requires a newer gcc 3.1 snapshot and recent binutils
configured for x86_64. 
For more information on x86-64 see also http://www.x86-64.org
The development is done in a public CVS tree at cvs.x86-64.org. See the
web site for more details.
Feedback please to discuss@x86-64.org or bugs@x86-64.org.

-Andi
