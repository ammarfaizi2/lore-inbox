Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSJQAOG>; Wed, 16 Oct 2002 20:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJQAOG>; Wed, 16 Oct 2002 20:14:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23824 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261563AbSJQAOF>; Wed, 16 Oct 2002 20:14:05 -0400
Date: Thu, 17 Oct 2002 01:19:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, willy@debian.org, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021017011957.A9589@flint.arm.linux.org.uk>
References: <20021016192630.L15163@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain> <20021016.165834.71112730.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016.165834.71112730.davem@redhat.com>; from davem@redhat.com on Wed, Oct 16, 2002 at 04:58:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 04:58:34PM -0700, David S. Miller wrote:
> No we still have to support platforms using flush_page_to_ram()
> 
> I didn't get a chance to deprecate this in 2.5.x, I wish I had.

I similarly wish that were so.  Any cleanups in this area are most
welcome.  Alas m68k and sparc still use flush_page_to_ram().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

