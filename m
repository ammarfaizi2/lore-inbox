Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVLOMYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVLOMYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 07:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVLOMYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 07:24:20 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33766 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965197AbVLOMYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 07:24:19 -0500
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible
	[00000001] code: swapper/1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Dec 2005 12:24:18 +0000
Message-Id: <1134649458.12421.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 00:35 -0800, Miles Lane wrote:
> [4294671.491000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0
> [4294671.492000] PCI- Detected Parity Error on 0000:00:1e.0 0000:00:1e.0


Can you send me an lspci -v

Andrew has a box where one of the PCI devices goes away without the
kernel updating its device list. That would match this behaviour.

