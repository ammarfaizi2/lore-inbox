Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTI0E7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 00:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTI0E7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 00:59:25 -0400
Received: from dp.samba.org ([66.70.73.150]:63664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262118AbTI0E7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 00:59:25 -0400
Date: Fri, 26 Sep 2003 23:59:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Prefered method to map PCI memory into userspace.
Message-ID: <20030926135908.GB9381@krispykreme>
References: <A8WS.6Uf.9@gated-at.bofh.it> <A8WR.6Uf.7@gated-at.bofh.it> <Aezg.6hA.9@gated-at.bofh.it> <m3zngqhmfr.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zngqhmfr.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Just curious - what does the X server use on these many systems then ?

FYI ppc64 and some ppc32 systems fall into the cant use /dev/mem
category. The answer is to use pci domains (ie using /proc/bus/pci/...
to be able to mmap PCI memory and IO regions)

Anton
