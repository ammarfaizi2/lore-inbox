Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVC1RZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVC1RZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVC1RZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:25:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:47007 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261960AbVC1RZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:25:00 -0500
Date: Mon, 28 Mar 2005 19:27:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: jayalk@intworks.biz
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [RFC 2.6.11.2 1/1] Add reboot fixup for gx1/cs5530a
In-Reply-To: <200503281415.j2SEFwg4014119@intworks.biz>
Message-ID: <Pine.LNX.4.62.0503281924090.28413@dragon.hyggekrogen.localhost>
References: <200503281415.j2SEFwg4014119@intworks.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2005 jayalk@intworks.biz wrote:

> Hi Riley, Dave, Peter, i386 boot/workaround maintainers,
> 
> +config X86_REBOOTFIXUPS
> +	bool "Enable X86 Board Specific Fixups for Reboot"
> +	depends on X86 
> +	default n
> +	---help---
> +	  This enables chipset and/or board specific fixups to be done
> +	  in order to get reboot to work correctly. This is only needed on
> +	  some combinations of hardware and BIOS. The symptom, for which 
> +	  this config is intended, is when reboot ends with a stalled/hung 
> +	  system. 
> +
> +	  Currently, the only fixup is for the Geode GX1/CS5530A/TROM2.1. 
> +	  combination. 
> +
> +	  Say Y if you want to enable the fixup.
> +	  Say N otherwise.
> +

I'd think it would be nice if the help text had a note telling the user if 
it's safe to always enable this or not, even if it's not needed. Something 
along the lines of "It's safe to always enable this config option even if 
you don't need it." or "This option should only be enabled if needed as it 
may cause problems otherwise." - whatever applies...


-- 
Jesper 


