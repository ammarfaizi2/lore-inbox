Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVCGRXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVCGRXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 12:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVCGRXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 12:23:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25323 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261940AbVCGRWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 12:22:30 -0500
Subject: Re: Linux 2.6.11.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: gene.heskett@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110060362.12513.48.camel@mindpipe>
References: <20050304175302.GA29289@kroah.com>
	 <20050305174654.J3282@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
	 <200503051649.58709.gene.heskett@verizon.net>
	 <1110060362.12513.48.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110215898.3072.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Mar 2005 17:18:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-03-05 at 22:06, Lee Revell wrote:
> Driver updates are a hard problem.  Nothing annoys users more than
> unsupported hardware.  But if you aggressively add support for new
> devices you can break things that have worked for ages.

You can however plan for them in advance. Guess why the -ac tree has an
ide
option to grab any otherwise unknown ide controller and stuff it in bios
tuned
DMA modes ?

Similarly you can generally apply "just PCI id" patches

