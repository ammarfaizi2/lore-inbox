Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbUL1Pdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUL1Pdz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 10:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUL1Pdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 10:33:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60317 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261786AbUL1Pdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 10:33:50 -0500
Subject: Re: [2.6 patch] /net/ax25/: some cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Adrian Bunk <bunk@stusta.de>, ralf@linux-mips.org,
       linux-hams@vger.kernel.org, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041227185151.2a7ceb71.davem@davemloft.net>
References: <20041212211339.GX22324@stusta.de>
	 <20041227185151.2a7ceb71.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104237408.20944.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 14:27:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-12-28 at 02:51, David S. Miller wrote:
> On Sun, 12 Dec 2004 22:13:39 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > The patch below contains the following cleanups:
> > - make two needlessly global functions static
> > - net/ax25/ax25_addr.c: remove the unused global function ax25digicmp

Dave this function is only unused because a patch in 2.6.10 broke AX.25
protocol support by removing the device and path checks. AX.25 is a link
layer protocol it is supposed to check the devices and arguably the
path. 
