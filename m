Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWBWMHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWBWMHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWBWMHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:07:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17901 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751042AbWBWMHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:07:13 -0500
Subject: Re: 2.6.16-rc4-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43FC8290.8070408@ums.usu.ru>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	 <43FC6B8F.4060601@ums.usu.ru>  <43FC8290.8070408@ums.usu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 12:10:58 +0000
Message-Id: <1140696659.19361.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-22 at 20:26 +0500, Alexander E. Patrakov wrote: 
> btw this also counts as snd-fm801 test). It is still slow because of 
> improper MWDMA2 setting (libata still doesn't know that master and slave 
> can use different DMA speeds on via pata).

The libata and pata_via in -mm are a bit out of date. The current libata
patch and driver for 2.6.16-rc4 knows how to do per device modes.

