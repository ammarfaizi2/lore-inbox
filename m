Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbVKIAA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbVKIAA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbVKIAA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:00:56 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27039
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030427AbVKIAAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:00:55 -0500
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051108222127.GA16542@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	 <20051108105923.GA31446@wohnheim.fh-wedel.de>
	 <m3zmofovsc.fsf@maxwell.lnxi.com>
	 <20051108183339.GB31446@wohnheim.fh-wedel.de>
	 <1131476269.18108.195.camel@tglx.tec.linutronix.de>
	 <20051108222127.GA16542@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: linutronix
Date: Wed, 09 Nov 2005 01:04:53 +0100
Message-Id: <1131494694.18108.216.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 23:21 +0100, Jörn Engel wrote:
> On Tue, 8 November 2005 19:57:49 +0100, Thomas Gleixner wrote:
> > 
> > The code _is_ ugly and ioctls are out of fashion, but your "remove it"
> > request is just silly as long as you dont provide a reasonable
> > alternative access to those bits.
> 
> You may have noticed the missing patch and figured that it was not a
> formal request for removal.  Still, I'll be happy when it's gone and
> am also happy that mtdchar mess is not spread over yet another file
> anymore.  Thanks, Arnd.

I'm deeply impressed by your insight and caring about Linux source code
quality. Thanks, Joern.

Complaining about legacy mess is easy blurb. Providing a clean solution
is obviously not on your agenda. 

	tglx


