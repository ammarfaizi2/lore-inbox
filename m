Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTIIVkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbTIIVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:40:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:51671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264619AbTIIVjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:39:54 -0400
Date: Tue, 9 Sep 2003 14:46:36 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Power: call save_state on PCI devices along with suspend
In-Reply-To: <1063141771.639.53.camel@gaston>
Message-ID: <Pine.LNX.4.44.0309091444110.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well... that wouldn't help with off-tree drivers...

But, we don't care about out-of-tree drivers, right? :)

> What I mean here is that our PCI driver API defines save_state, we shall
> either "support" it some way, or get rid of it completely... but then we
> lose the ability to move a PCI driver back & forth with 2.4 ... (do we
> care ?)

I think the addition of the method was a mistake and it should be fixed 
up. The fact there are only those 4 users should make it trivial in both 
2.6 and 2.4 to do so. 

> If you prefer just fixing those 4 ones, then let's get rid of the
> save_state field in pci_driver completely...

I completely agree. 


	Pat

