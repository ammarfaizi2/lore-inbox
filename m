Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVASOuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVASOuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVASOuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:50:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4627 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261741AbVASOtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:49:01 -0500
Subject: Re: [PATCH] raid6: altivec support
From: David Woodhouse <dwmw2@infradead.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, Jon Masters <jonathan@jonmasters.org>,
       Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	 <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 14:48:03 +0000
Message-Id: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> We did talk about looking at using some work Ben did in ppc64 with OF 
> in ppc32.  John Masters was looking into this, but I havent heard much
> from him on it lately.
> 
> The firmware interface on the ppc32 embedded side is some what broken 
> in my mind.

The binary structure which changes every few weeks and which is shared
between the bootloader and the kernel? Yeah, "somewhat broken" is one
way of putting it :)

The ARM kernel does it a lot better with tag,value pairs.

-- 
dwmw2

