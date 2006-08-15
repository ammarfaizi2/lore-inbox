Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWHOUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWHOUic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHOUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:38:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47529 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750969AbWHOUic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:38:32 -0400
Subject: Re: [PATCH] const struct tty_operations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200608152023.k7FKNbco009918@ccure.user-mode-linux.org>
References: <200608152023.k7FKNbco009918@ccure.user-mode-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 21:58:51 +0100
Message-Id: <1155675531.24077.312.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-15 am 16:23 -0400, ysgrifennodd Jeff Dike:
> 53 drivers are affected.  I checked the history of a bunch of them,
> and in most cases, there have been only a handful of maintenance
> changes in the last six months.  serial_core.c was the busiest one
> that I looked at.

For the tty layer and unmaintained drivers

Acked-by: Alan Cox <alan@redhat.com>

I'm all for making better use of const.


