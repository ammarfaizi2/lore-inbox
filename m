Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVHQQBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVHQQBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVHQQBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:01:32 -0400
Received: from mail.ccur.com ([208.248.32.212]:29768 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S1751155AbVHQQBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:01:32 -0400
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
From: Jim Houston <jim.houston@ccur.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <430262C5.20503@adaptec.com>
References: <430262C5.20503@adaptec.com>
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1124294489.2802.107.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Aug 2005 12:01:29 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2005 16:01:31.0350 (UTC) FILETIME=[EF0AE760:01C5A344]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 18:03, Luben Tuikov wrote:

> If idr_get_new() or idr_remove() is used in IRQ context,
> then we may get a lockup when idr_pre_get was called
> in process context and an IRQ interrupted while it held
> the idp lock.

Hi Everyone,

Luben's changes make sense please merge them.

Jim Houston - Concurrent Computer Corp.



