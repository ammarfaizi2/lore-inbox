Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTJFTBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJFTBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:01:46 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:53757 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S262129AbTJFTBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:01:44 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] Backing Store for sysfs
In-Reply-To: <DI7S.58w.13@gated-at.bofh.it>
References: <Dzxw.1wW.3@gated-at.bofh.it> <DGfG.4UY.3@gated-at.bofh.it> <DHv1.5Ir.1@gated-at.bofh.it> <DHEU.7ET.19@gated-at.bofh.it> <DHY6.3c0.7@gated-at.bofh.it> <DI7S.58w.13@gated-at.bofh.it>
Date: Mon, 6 Oct 2003 21:01:40 +0200
Message-Id: <E1A6ac0-0000rX-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Oct 2003 20:20:16 +0200, you wrote in linux.kernel:

> Does that make more sense?  We can't just look at what happens with this
> patch without actually accessing all of the sysfs tree, as that will be
> the "normal" case.

Well, the normal case for me and other people not using any hot-pluggable
devices will be to run a hotplug agent that does absolutely nothing... so
in my case, the proposed patch would help - more memory available for the
normal work I do.

With a static /dev and no hotpluggable stuff around, there is no need
for and hotplug agent being there at all. And I do think such system
are not too uncommon, so considering them would probably be nice.

-- 
Ciao,
Pascal
