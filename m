Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSEEA0K>; Sat, 4 May 2002 20:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315793AbSEEA0J>; Sat, 4 May 2002 20:26:09 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:62968
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315792AbSEEA0I>; Sat, 4 May 2002 20:26:08 -0400
Message-ID: <3CD47C1D.12573A61@eyal.emu.id.au>
Date: Sun, 05 May 2002 10:26:05 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: unresolved kmap_pagetable
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD339B7.5BEB2DB4@eyal.emu.id.au> <20020504092531.L1396@dualathlon.random> <3CD3E505.A688C20A@eyal.emu.id.au> <20020504154943.W1396@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sat, May 04, 2002 at 11:41:25PM +1000, Eyal Lebedinsky wrote:
> > Well, this may be a problem for NVdriver (a mostly binary only driver)
> > which I use.
> 
> This should fix it:
> 
> diff -urN NVIDIA_kernel-1.0-2313/nv.c .pte-highmem/nv.c
> --- NVIDIA_kernel-1.0-2313/nv.c Tue Nov 27 21:39:17 2001
> +++ NVIDIA_kernel-1.0-2313.pte-highmem/nv.c     Sun Feb  3 16:35:18 2002

Applied to NVIDIA_kernel-1.0-2880 and it builds fine (on -aa2)
and booted OK. Thanks.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
