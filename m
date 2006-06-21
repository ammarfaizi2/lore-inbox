Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWFUKfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWFUKfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWFUKfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:35:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19867 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751490AbWFUKfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:35:55 -0400
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
	for PDC202XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik@echohome.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 11:51:13 +0100
Message-Id: <1150887073.15275.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 21:19 -0400, ysgrifennodd Erik Ohrnberger:
> Downloaded kernel code.  
> Applied the IDE patches (http://zeniv.linux.org.uk/~alan/IDE)
> 	(had to apply the change from ata_data_xfer calls to ops->data_xfer
> 	(no big deal, I speak C )

What tree are you working against. The patches I put up are versus
2.6.17 not -mm. Also check in include/linux/libata.h that
ATA_ENABLE_PATA is defined (its down with the debug options). The patch
should have enabled it however.

