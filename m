Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWI2VTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWI2VTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWI2VTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:19:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12943 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964815AbWI2VTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:19:18 -0400
Subject: Re: 2.6.18-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Jim Cromie <jim.cromie@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200609292258.24546.ak@suse.de>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <200609292236.15330.ak@suse.de> <20060929203227.GA5051@elte.hu>
	 <200609292258.24546.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 22:44:08 +0100
Message-Id: <1159566248.13029.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-29 am 22:58 +0200, ysgrifennodd Andi Kleen:
> 2978333  640752  416100 4035185  3d9271 obj32-up-noacpi/vmlinux
> 2947808  612088  400292 3960188  3c6d7c obj32-up-noacpi-noapic/vmlinux
> 
> ~30k

30K is a lot on an embedded x86 box.

> You might be able to do without ACPI on your embedded system.

Most embedded people don't use ACPI for some strange reason related to
the fact its bloated, hard to get right in the firmware and sucks. That
is one that makes sense to keep.

Alan

