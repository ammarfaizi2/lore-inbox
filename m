Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756084AbWKVRub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbWKVRub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756085AbWKVRub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:50:31 -0500
Received: from ns2.suse.de ([195.135.220.15]:7828 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1756084AbWKVRua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:50:30 -0500
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] X86_genericarch needs SMP?
Date: Wed, 22 Nov 2006 18:50:11 +0100
User-Agent: KMail/1.9.5
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20061122094842.75f3d35b.randy.dunlap@oracle.com>
In-Reply-To: <20061122094842.75f3d35b.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221850.11965.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 18:48, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> With
> CONFIG_SMP=n, CONFIG_X86_GENERICARCH=y
> (and CONFIG_X86_SUMMIT=n), kernel build gets:
> 
> arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
> summit.c:(.text+0x54): undefined reference to `apicid_2_node'
> 
> so should X86_GENERICARCH depend on SMP?
> or should there be more ifdefs in the source files?

I already fixed that here in a different way, but the patch didn't make 
it to Linus yet.

-Andi
