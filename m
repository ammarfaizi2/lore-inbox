Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVASXbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVASXbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVASX3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:29:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:26093 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261978AbVASX1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:27:05 -0500
Subject: Re: [PATCH] raid6: altivec support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, Paul Mackerras <paulus@samba.org>,
       Jon Masters <jonathan@jonmasters.org>, Olaf Hering <olh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1106146083.26551.526.camel@hades.cambridge.redhat.com>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
	 <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
	 <1106146083.26551.526.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 10:25:29 +1100
Message-Id: <1106177129.5327.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 14:48 +0000, David Woodhouse wrote:
> On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
> > We did talk about looking at using some work Ben did in ppc64 with OF 
> > in ppc32.  John Masters was looking into this, but I havent heard much
> > from him on it lately.
> > 
> > The firmware interface on the ppc32 embedded side is some what broken 
> > in my mind.
> 
> The binary structure which changes every few weeks and which is shared
> between the bootloader and the kernel? Yeah, "somewhat broken" is one
> way of putting it :)
> 
> The ARM kernel does it a lot better with tag,value pairs.

And ppc64 adds a flattened device-tree format, even better imho :)

Ben.


