Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUHOVyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUHOVyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUHOVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:54:12 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14049 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266925AbUHOVyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:54:11 -0400
Subject: Re: Linux SATA RAID FAQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092603242.7421.6.camel@nomade>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
	 <1092315392.21994.52.camel@localhost.localdomain> <411BA7A1.403@pobox.com>
	 <411BA940.5000300@pobox.com>
	 <1092520163.27405.11.camel@localhost.localdomain>
	 <1092603242.7421.6.camel@nomade>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092603106.18410.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 21:51:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 21:54, Xavier Bestel wrote:
> Isn't sufficient to have it do ordered writes ? If you power your
> machine off, you'll have things half-written anyway, the only thing
> important with journaled filesystems (and raid5 arrays) is to have
> writes staying between barriers.

True to a point but 2Gb of data going walkies will offend even if the
file system is gloriously intact

