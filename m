Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTFEG4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 02:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTFEG4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 02:56:44 -0400
Received: from ns.suse.de ([213.95.15.193]:18182 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264486AbTFEG4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 02:56:43 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is sys_sysfs used?
References: <Pine.LNX.4.44.0306041124250.13077-100000@cherise.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Jun 2003 09:09:59 +0200
In-Reply-To: <Pine.LNX.4.44.0306041124250.13077-100000@cherise.suse.lists.linux.kernel>
Message-ID: <p731xy96lvc.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> I see that only one architecture defines __NR_sysfs: x86-64, though it
> appears most architectures mention it in arch/*/kernel/entry.S (or 
> equivalent). 

That's because x86-64 has a merged entry.S/unistd.h. The other architectures
probably use some other name in unistd.h

I think it can be removed safely from the AMD64 64bit table at least.

-Andi
