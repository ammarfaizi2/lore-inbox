Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVAIKo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVAIKo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 05:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbVAIKo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 05:44:29 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:64153 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262077AbVAIKo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 05:44:26 -0500
Date: Sun, 9 Jan 2005 11:44:25 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>, Linas Vepstas <linas@austin.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
Message-ID: <20050109104425.GA9524@janus>
References: <20050106195812.GL22274@austin.ibm.com> <20050106161241.11a8d07c.akpm@osdl.org> <20050107002648.GD14239@krispykreme.ozlabs.ibm.com> <41DDD6FA.2050403@osdl.org> <1105062162.24896.311.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105062162.24896.311.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 01:54:41AM +0000, Alan Cox wrote:
> 
> Ditto on x86 - several of us raised the ideal of ACPI actually defining
> a "log area" in the E820 map types or some other ACPI resource that
> would be a chunk of RAM used for logs that wasn't going to get bios
> eaten on a soft reboot but could be reclaimed by the OS but we didn't
> get it.

What about UDP (or just eth) broadcasting the oops and catching it
on another system? That would be useful if one has a lot of systems
(I have about 40) and makes it possible to immediately alert someone
without the need for ping games.

-- 
Frank
