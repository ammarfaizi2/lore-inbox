Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJHRnu>; Mon, 8 Oct 2001 13:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277030AbRJHRnm>; Mon, 8 Oct 2001 13:43:42 -0400
Received: from [209.237.5.66] ([209.237.5.66]:15780 "EHLO clyde.stargateip.com")
	by vger.kernel.org with ESMTP id <S277024AbRJHRnW>;
	Mon, 8 Oct 2001 13:43:22 -0400
From: "Ian Thompson" <ithompso@stargateip.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How can I jump to non-linux address space?
Date: Mon, 8 Oct 2001 10:43:45 -0700
Message-ID: <NFBBIBIEHMPDJNKCIKOBGEOPCAAA.ithompso@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <20011006085743.A23628@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> functions already do the right things for you.  setup_mm_for_reboot()
> will remap all of user space with a 1:1 virtual to physical mapping,

Am I correct in assuming that this will not remap the kernel address space?
If I'm trying to jump from the kernel to this physical address, will I need
to go through user space first?

-ian

