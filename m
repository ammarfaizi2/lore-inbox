Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285724AbRLHBX3>; Fri, 7 Dec 2001 20:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285731AbRLHBXT>; Fri, 7 Dec 2001 20:23:19 -0500
Received: from [144.137.80.33] ([144.137.80.33]:32496 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S285724AbRLHBXH>;
	Fri, 7 Dec 2001 20:23:07 -0500
Message-ID: <3C116B1E.9C153277@eyal.emu.id.au>
Date: Sat, 08 Dec 2001 12:21:34 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.17-pre6
In-Reply-To: <Pine.LNX.4.21.0112071935050.22884-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Some critical stuff this time: Notably the multithread coredump deadlock
> fix and the copy_user_highpage fix for some architectures...
> 
> pre6:

Everything possible built as a module. The wan error I undertsand
is something we really like as it is by now a permanent feature, but
the sis one is new.

depmod: *** Unresolved symbols in
/lib/modules/2.4.17-pre6/kernel/drivers/char/drm/sis.o
depmod:         sis_malloc_Ra3329ed5
depmod:         sis_free_Rced25333
depmod: *** Unresolved symbols in
/lib/modules/2.4.17-pre6/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
