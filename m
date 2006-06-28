Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWF1Pcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWF1Pcf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbWF1Pce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:32:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932164AbWF1Pcd
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:32:33 -0400
Subject: Re: PATA driver patch for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: Linux-Kernel@vger.kernel.org
In-Reply-To: <3b0ffc1f0606280825t7d84f4d9u3ce1e5a97dc849aa@mail.gmail.com>
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <3b0ffc1f0606250823h49ec5c9cy180d4941d6c9c8b@mail.gmail.com>
	 <3b0ffc1f0606280825t7d84f4d9u3ce1e5a97dc849aa@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 16:48:50 +0100
Message-Id: <1151509731.15166.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 11:25 -0400, ysgrifennodd Kevin Radloff:
> Ick, apparently I wasn't running what I was thought I was running. It
> appears that the only reason pata_pcmcia was working at all was
> because I was still using the 2.6.17-rc4-ide1 version of the patch (on
> 2.6.17 final). The 2.6.17-ide1 version of pata_pcmcia fails like so
> (with my usual 1GB Sandisk card):

Yep. There are some uglies with the pcmcia layer. Fixed in the devel
tree for a while

Alan

