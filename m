Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSGXTeu>; Wed, 24 Jul 2002 15:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSGXTeu>; Wed, 24 Jul 2002 15:34:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17170 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317641AbSGXTet>;
	Wed, 24 Jul 2002 15:34:49 -0400
Message-ID: <3D3F019A.80BC3632@zip.com.au>
Date: Wed, 24 Jul 2002 12:35:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David F Barrera <dbarrera@us.ibm.com>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,  
 mode:0x0
References: <OF58871EFC.4272F3EB-ON85256C00.004B3677@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David F Barrera wrote:
> 
> Andrew,
> 
> I tried the change to ptrace.c, but it did not work.  I cannot boot the
> machine.  It gives an oops upon boot.

That won't be due to the ptrace change.  Suggest you do a clean
build and if the oops is still there, please pass it through ksymoops and
let us know.

And please drop the ptrace.c change and use
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.27/lru-removal.patch
instead.

Thanks.
