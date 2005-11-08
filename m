Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVKHWVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVKHWVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVKHWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:21:38 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:29407 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965149AbVKHWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:21:37 -0500
Date: Tue, 8 Nov 2005 23:21:27 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
Message-ID: <20051108222127.GA16542@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162712.921102000@b551138y.boeblingen.de.ibm.com> <20051108105923.GA31446@wohnheim.fh-wedel.de> <m3zmofovsc.fsf@maxwell.lnxi.com> <20051108183339.GB31446@wohnheim.fh-wedel.de> <1131476269.18108.195.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1131476269.18108.195.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 November 2005 19:57:49 +0100, Thomas Gleixner wrote:
> 
> The code _is_ ugly and ioctls are out of fashion, but your "remove it"
> request is just silly as long as you dont provide a reasonable
> alternative access to those bits.

You may have noticed the missing patch and figured that it was not a
formal request for removal.  Still, I'll be happy when it's gone and
am also happy that mtdchar mess is not spread over yet another file
anymore.  Thanks, Arnd.

Jörn

-- 
Mac is for working, 
Linux is for Networking, 
Windows is for Solitaire! 
-- stolen from dc
