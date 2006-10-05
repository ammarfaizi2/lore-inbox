Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWJEVfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWJEVfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWJEVfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:35:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1977 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932234AbWJEVfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:35:42 -0400
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610051953.23510.ak@suse.de>
References: <200610051910.25418.ak@suse.de> <200610051931.23884.ak@suse.de>
	 <4525445C.6060901@garzik.org>  <200610051953.23510.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 23:00:49 +0100
Message-Id: <1160085649.1607.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 19:53 +0200, ysgrifennodd Andi Kleen:
> If you have a patch that works with all known BIOS bugs (including Mac Mini,
> a random Intel 975 board and a Asus AMD K8 board with PCI Express) please share it.

Well you currently don't have such a patch so thats a disingenuous
argument. More useful for the short term till this is fixed might be to
provide

	pci_requires_mmconfig(dev)

which forces it on for that device regardless and may (internal
implementation detail) print a warning "if your system hangs at this
point.." type message.

That gets us the best of both worlds.

