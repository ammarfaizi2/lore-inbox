Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSEOLKH>; Wed, 15 May 2002 07:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSEOLKG>; Wed, 15 May 2002 07:10:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2321 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313512AbSEOLKF>; Wed, 15 May 2002 07:10:05 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Wed, 15 May 2002 12:29:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Tony.P.Lee@nokia.com, lmb@suse.de,
        woody@co.intel.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
In-Reply-To: <20020515010107.A31154@devserv.devel.redhat.com> from "Pete Zaitcev" at May 15, 2002 01:01:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177wy8-0001hK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The thing about Infiniband is that its scope is so great.
> If you consider Infiniband was only a glorified PCI with serial
> connector, the congestion control is not an issue. Credits

Congestion control is always an issue 8

> are quite sufficient to provide per link flow control, and
> everything would work nicely with a couple of switches.
> Such was the original plan, anyways, but somehow cluster
> ninjas managed to hijack the spec and we have the rabid
> overengineering running amok. In fact, they ran so far
> that Intel jumped ship and created PCI Express, and we
> have discussions about congestion control. Sad, really...

My interest is in the question "does infiniband have usable congestion
control for tcp/clustering/networking". I don't actually care if it doesn't
and I'd rather have most congestion control in software anyway.

Alan

