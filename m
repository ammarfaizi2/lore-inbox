Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTLOUDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTLOUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:03:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22211 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263965AbTLOUDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:03:42 -0500
Message-ID: <3FDE1391.7030306@pobox.com>
Date: Mon, 15 Dec 2003 15:03:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDC9DC5.2070302@intel.com> <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312151023570.1488@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> You _really_ need to allocate a FIXMAP entry (just one), and then use
> 
> 	set_fixmap_nocache(FIX_PCIEXPRESS, phys);


neat.  dumb question though...  how portable is set_fixmap_nocache()?

I only see it on four architectures, and I'm sure PCI Express will 
appear on more than that eventually.

	Jeff



