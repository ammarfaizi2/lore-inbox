Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVBILxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVBILxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVBILxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 06:53:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30367
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261811AbVBILxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 06:53:36 -0500
Subject: Re: Preempt Real-time for ARM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>, LKML <linux-kernel@vger.kernel.org>,
       Sven Dietrich <sdietrich@mvista.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <20050209113140.GB13274@elte.hu>
References: <1107628604.5065.54.camel@dhcp153.mvista.com>
	 <1107948492.17747.31.camel@tglx.tec.linutronix.de>
	 <20050209113140.GB13274@elte.hu>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 12:53:30 +0100
Message-Id: <1107950010.17747.35.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-09 at 12:31 +0100, Ingo Molnar wrote:
> > I'm just waiting until the new SMP bits are there before I have
> > another go and clean up the missing SMP bits.
> 
> any chances for (most of) these bits going upstream as well? In any
> case, the -RT tree can be a testbed for this.

I guess this has to be discussed with Russell in detail. The UP bits are
quite simple and we can preserve the ARM oddities by tweaking the
generic layer a bit. The SMP stuff was/is work in progress, but what I
have seen until now is not too scary, but needs some careful thoughts.

tglx


