Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281773AbRLRPQq>; Tue, 18 Dec 2001 10:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRLRPQh>; Tue, 18 Dec 2001 10:16:37 -0500
Received: from m749-mp1-cvx1b.edi.ntl.com ([62.253.10.237]:18926 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281773AbRLRPQV>; Tue, 18 Dec 2001 10:16:21 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181411.fBIEBXC15455@pinkpanther.swansea.linux.org.uk>
Subject: Re: Common removable media interface?
To: jkrahn@nc.rr.com (Joe Krahn)
Date: Tue, 18 Dec 2001 14:11:32 +0000 (GMT)
Cc: axboe@suse.de (Jens Axboe), linux-kernel@vger.kernel.org
In-Reply-To: <3C1F47D4.8964A190@nc.rr.com> from "Joe Krahn" at Dec 18, 2001 08:42:44 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, you are right. Bloat is bad. So,
> would you say that new drivers should keep ioctls
> to a bare minimum, much less than cdrom.c, and just
> provide generic access, like SG_IO/HDIO_DRIVE_CMD,
> as a general rule from now on?
> (Sounds OK to me...)

Even better would be to move the from the existing drivers into a kernel
compat module you can load for older apps/tools. Our module tools and kernel
code already allow that module to be loaded on demand

Alan

