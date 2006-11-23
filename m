Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757386AbWKWPI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbWKWPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757390AbWKWPI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:08:27 -0500
Received: from cantor2.suse.de ([195.135.220.15]:18156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1757386AbWKWPI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:08:26 -0500
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>, akpm@osdl.org
Subject: Re: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re: 2.6.19-rc6-mm1)
References: <20061123021703.8550e37e.akpm@osdl.org>
	<45657A41.2040400@reub.net>
	<Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz>
From: Andi Kleen <ak@suse.de>
Date: 23 Nov 2006 16:08:22 +0100
In-Reply-To: <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz>
Message-ID: <p731wnu42vt.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jkosina@suse.cz> writes:
> 
> cpu_vsyscall_notifier() is defined only when CONFIG_HOTPLUG_CPU is 
> defined.

It's already long fixed in Linus' tree (in
6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3) I wonder why that didn't
makeit into Andrew's.

Andrew, time to update your linus-patch?

-Andi
