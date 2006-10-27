Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWJ0XCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWJ0XCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWJ0XCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:02:02 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60606 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750956AbWJ0XCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:02:00 -0400
Subject: Re: [PATCH ??] Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florin Malita <fmalita@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       proski@gnu.org, cate@debian.org, gianluca@abinetworks.biz
In-Reply-To: <45428EAD.6040005@gmail.com>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
	 <20061026102630.ad191d21.randy.dunlap@oracle.com>
	 <1161959020.12281.1.camel@laptopd505.fenrus.org>
	 <20061027082741.8476024a.randy.dunlap@oracle.com>
	 <20061027112601.dbd83c32.akpm@osdl.org>  <45428EAD.6040005@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Oct 2006 00:05:06 +0100
Message-Id: <1161990307.16839.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-27 am 18:56 -0400, ysgrifennodd Florin Malita:
> Also, since driverloader is not GPL-compatible (MODULE_LICENSE("see
> LICENSE file; Copyright (c)2003-2004 Linuxant inc.")), that check is
> redundant. How about removing it (applies on top of Randy's patch)?
> 
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com>

NAK

Older versions of Linuxant's driverloader claim GPL\0some other text and
systematically set out to abuse the license tag code. We should continue
to carry the code for this.

Alan

