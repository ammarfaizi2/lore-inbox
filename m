Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUGIVeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUGIVeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUGIVeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:34:09 -0400
Received: from snickers.hotpop.com ([38.113.3.51]:63652 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S264061AbUGIVeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:34:06 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Guido Guenther <agx@sigxcpu.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_, cleanup DEBUG, backlight control on ppc
Date: Sat, 10 Jul 2004 05:33:56 +0800
User-Agent: KMail/1.5.4
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20040601041604.GA2344@bogon.ms20.nix> <1087832204.22683.11.camel@gaston> <20040709112539.GA2286@bogon.ms20.nix>
In-Reply-To: <20040709112539.GA2286@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407100533.59503.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 July 2004 19:25, Guido Guenther wrote:
> On Mon, Jun 21, 2004 at 10:36:44AM -0500, Benjamin Herrenschmidt wrote:
> > Ok, well, it looks good to me. There is no active maintainer for rivafb
> > so, I suppose if nobody complains of breakage, it should be fine.
>
> Since this isn't in yet. Here's another version that:
>  - fixes the PCI-IDs (needed to get it to work on at least the NV17)
>  - cleans up the DEBUG option (similar to the new radeonfb). This also
>    makes it easy to replace printk by btext_printf() (on ppc) or similar
>    to ease debugging of the fb code when all else fails.
>  - adds backlight control for Apple powerbooks
> Patch is against 2.6.7-bk20. Please apply,
>  -- Guido

Tried the patch, and works okay for me (NV10 x86).  I'm not really too
keen on making debug printing as a kernel config option, but it's a minor point.
This patch should be applied.

Tony


