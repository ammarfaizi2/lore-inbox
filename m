Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRLHQcX>; Sat, 8 Dec 2001 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRLHQcN>; Sat, 8 Dec 2001 11:32:13 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40424 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282213AbRLHQcH>; Sat, 8 Dec 2001 11:32:07 -0500
Date: Sat, 8 Dec 2001 11:32:00 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Eric Lammerts <eric@lammerts.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Would the father of init_mem_lth please stand up
Message-ID: <20011208113200.A7913@devserv.devel.redhat.com>
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com> <Pine.LNX.4.43.0112081240080.7546-100000@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.43.0112081240080.7546-100000@ally.lammerts.org>; from eric@lammerts.org on Sat, Dec 08, 2001 at 12:47:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 12:47:05PM +0100, Eric Lammerts wrote:

> I agree it's ugly, but why would kfree be called on dangling pointers?
> All those pointers are initialized again on every sd_init() call. And
> there are no "goto cleanup_mem"s between the kmallocs.
> 
> Eric

I was too rush - indeed there are no gotos between kmallocs.
So the scenario that I presented cannot happen.

-- Pete
