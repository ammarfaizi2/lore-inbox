Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315751AbSEDBah>; Fri, 3 May 2002 21:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSEDBag>; Fri, 3 May 2002 21:30:36 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:46837
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315751AbSEDBag>; Fri, 3 May 2002 21:30:36 -0400
Message-ID: <3CD339B7.5BEB2DB4@eyal.emu.id.au>
Date: Sat, 04 May 2002 11:30:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: unresolved kmap_pagetable
In-Reply-To: <20020503203738.E1396@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Full patchkit:
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz

This is a new symbol introduced in -aa1. It ends up in drivers through
new header definitions rather than by direct use.

Should be exported?


depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-aa1/kernel/drivers/ieee1394/dv1394.o
depmod:         kmap_pagetable
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-aa1/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode
depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-aa1/kernel/drivers/video/NVdriver
depmod:         kmap_pagetable

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
