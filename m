Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUKBR0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUKBR0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUKBRZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:25:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:59792 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261412AbUKBRXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 12:23:50 -0500
Date: Tue, 2 Nov 2004 18:23:47 +0100
From: Andi Kleen <ak@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, torvalds@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 11/14] FRV: Add FDPIC ELF binary format driver
Message-ID: <20041102172347.GC29684@wotan.suse.de>
References: <20041102030703.6e16a5bb.akpm@osdl.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JULwr023235@warthog.cambridge.redhat.com> <26188.1099414032@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26188.1099414032@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:47:12PM +0000, David Howells wrote:
> 
> > This patch breaks the x86_64 build in gruesome ways.
> 
> So I see. It seems x86_64 overrides the setup_arg_pages() function in the IA32
> emulator.
> 
> Andi: Would you be willing to take an arch patch to change this? Or would you
> rather fix it yourself?

Just submit a patch to fix it together with your patch. Also you
should use grep -r, there are other architectures who do 32bit ELF
emulation in the same way.

-Andi
