Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVCJBWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVCJBWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVCJBVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:21:31 -0500
Received: from fmr22.intel.com ([143.183.121.14]:27856 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262444AbVCJA5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:57:42 -0500
Message-Id: <200503100057.j2A0v6g27712@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andi Kleen'" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 16:57:06 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUk/vcXB6PKjh7PRESRQ5g7oVIo7wADM0RQ
In-Reply-To: <m1r7iov1ya.fsf@muc.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote on Wednesday, March 09, 2005 3:23 PM
> > Just to clarify here, these data need to be taken at grain of salt. A
> > high count in _spin_unlock_* functions do not automatically points to
> > lock contention.  It's one of the blind spot syndrome with timer based
> > profile on ia64.  There are some lock contentions in 2.6 kernel that
> > we are staring at.  Please do not misinterpret the number here.
>
> Why don't you use oprofileÂ>? It uses NMIs and can profile "inside"
> interrupt disabled sections.

The profile is taken on ia64.  we don't have nmi.  Oprofile will produce
the same result.

- Ken


