Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSLDVqm>; Wed, 4 Dec 2002 16:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267108AbSLDVqm>; Wed, 4 Dec 2002 16:46:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267104AbSLDVqm>;
	Wed, 4 Dec 2002 16:46:42 -0500
Subject: Re: [PATCH] NMI notifiers for 2.5
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <p731y4xtulg.fsf@oldwotan.suse.de>
References: <1039027142.20387.11.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel> 
	<p731y4xtulg.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 13:54:13 -0800
Message-Id: <1039038853.20387.19.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For a more comprehensive variant see include/asm-x86_64/kdebug.h	
> The x86-64 variant cannot be 1:1 copied because it's still incomplete
> and e.g. does not implement veto for all places where it's needed.
> 

Didn't look in x86_64 code.  Would it just make more sense to turn this
into an architecture independent mechanism and provide sample versions
for x86_64 and i386?

