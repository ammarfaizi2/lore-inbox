Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUG3VIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUG3VIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267848AbUG3VIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 17:08:00 -0400
Received: from web14921.mail.yahoo.com ([216.136.225.5]:48485 "HELO
	web14921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267846AbUG3VH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 17:07:56 -0400
Message-ID: <20040730210755.23849.qmail@web14921.mail.yahoo.com>
Date: Fri, 30 Jul 2004 14:07:55 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz
Cc: Martin Mares <mj@ucw.cz>, Jon Smirl <jonsmirl@yahoo.com>,
       Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <200407301349.12020.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> We can get away without caching a copy of the ROM in the kernel if we
> require 
> userspace to cache it before the driver takes control of the card
> (i.e. at 
> POST time).  Otherwise, the kernel will have to take care of it.

You may also need ROM access when resuming a suspended device so we
need to plan for that case too.

> 
> Jesse
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Express yourself with Y! Messenger! Free. Download now. 
http://messenger.yahoo.com
