Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSJUOml>; Mon, 21 Oct 2002 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSJUOml>; Mon, 21 Oct 2002 10:42:41 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:32948 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261421AbSJUOmk>; Mon, 21 Oct 2002 10:42:40 -0400
Subject: Re: [PATCH] shmem missing cache flush
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rmk@arm.linux.org.uk, hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021016.171626.112600105.davem@redhat.com>
References: <Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain>
	<20021016.165834.71112730.davem@redhat.com>
	<20021017011957.A9589@flint.arm.linux.org.uk> 
	<20021016.171626.112600105.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:04:17 +0100
Message-Id: <1035212657.27259.154.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 01:16, David S. Miller wrote:
>    I similarly wish that were so.  Any cleanups in this area are most
>    welcome.  Alas m68k and sparc still use flush_page_to_ram().
> 
> I'd consider it more than rude to break this 5 days before
> feature freeze. :-)
> 
> Put this at the top of the list of 2.7.x todo and let's not
> forget it this time.

I disagree here. Its a measurable performance item, and its actually
going to break less code than for example the last minute scsi and bio
changes have done

