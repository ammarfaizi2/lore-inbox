Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288928AbSAUXw0>; Mon, 21 Jan 2002 18:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAUXwQ>; Mon, 21 Jan 2002 18:52:16 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:6079 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S288928AbSAUXwG>; Mon, 21 Jan 2002 18:52:06 -0500
Date: Mon, 21 Jan 2002 18:52:05 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201212352.g0LNq5802844@devserv.devel.redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <mailman.1011386221.24072.linux-kernel2news@redhat.com>
In-Reply-To: <20020118130209.J14725@altus.drgw.net> <3C4875DB.9080402@embeddededge.com> <mailman.1011386221.24072.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It [GFP_HIGH] is a trivial fix whereas backing
> out this ability to call pci_alloc_consistent from interrupts is not
> a trivial change at all.

David, would you make a statement about pci_free_consistent.
I find it annoying that it cannot be called from an interrupt.

-- Pete
