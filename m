Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSHBAjn>; Thu, 1 Aug 2002 20:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSHBAjn>; Thu, 1 Aug 2002 20:39:43 -0400
Received: from dial-2-203.emitel.hu ([195.228.182.203]:9856 "EHLO
	bazooka.enclave.net") by vger.kernel.org with ESMTP
	id <S317427AbSHBAjm>; Thu, 1 Aug 2002 20:39:42 -0400
Date: Fri, 2 Aug 2002 02:38:32 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Banai Zoltan <bazooka@emitel.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
Message-ID: <20020802003832.GA439@bazooka.saturnus.vein.hu>
References: <20020801233253.GA524@bazooka.saturnus.vein.hu> <Pine.GSO.4.21.0208012000120.13359-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208012000120.13359-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
From: Banai Zoltan <bazooka@emitel.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 08:12:34PM -0400, Alexander Viro wrote:
> 
> Argh.  My fault - it's devfs-only code and it didn't get tested ;-/
> 
> Fix: replace line 470 with
> 		p[part].de = NULL;
> 
Thanks, that help!

But it does not boot,( nor does 2.5.24)
with 2.5.30 it panics at PNP BIOS initalisation,
without PNPBIOS it freezes after loop device init(no network card)
after network card init if configured (Intel e100).
No SysRq helps.:(

-- 
Banai Zoltan
