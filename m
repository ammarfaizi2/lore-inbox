Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVASOsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVASOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVASOqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:46:37 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:20411 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261737AbVASOqC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:46:02 -0500
In-Reply-To: <1106120622.10851.42.camel@baythorne.infradead.org>
References: <1106120622.10851.42.camel@baythorne.infradead.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <BD84893E-6A28-11D9-AC28-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: Paul Mackerras <paulus@samba.org>, Jon Masters <jonathan@jonmasters.org>,
       Olaf Hering <olh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] raid6: altivec support
Date: Wed, 19 Jan 2005 08:45:19 -0600
To: "David Woodhouse" <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

We did talk about looking at using some work Ben did in ppc64 with OF 
in ppc32.  John Masters was looking into this, but I havent heard much 
from him on it lately.

The firmware interface on the ppc32 embedded side is some what broken 
in my mind.

- kumar

On Jan 19, 2005, at 1:43 AM, David Woodhouse wrote:

> On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
>  > We should probably "backport" that simplification to ppc32...
>
> Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
>  like mips/parisc/s390. Or would that get vetoed on the basis that we
>  don't have all that horrid non-OF platform support in ppc64 yet, and
> we're still kidding ourselves that all those embedded vendors will
>  either not notice ppc64 or will use OF?
>
> -- 
> dwmw2
>
>
>
> -
>  To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

