Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273005AbTG3QqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273006AbTG3QqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:46:13 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45318 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S273005AbTG3QqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:46:11 -0400
Date: Wed, 30 Jul 2003 18:37:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test2 wanXL driver
Message-ID: <20030730183745.A3878@electric-eye.fr.zoreil.com>
References: <m3lluhnj6e.fsf@defiant.pm.waw.pl> <20030730002959.A23749@electric-eye.fr.zoreil.com> <m3u195lykx.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3u195lykx.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Wed, Jul 30, 2003 at 01:09:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
> Francois Romieu <romieu@fr.zoreil.com> :
[...]
> > dma_map_single() is probably preferred over virt_to_bus().
> 
> Never heard of it in fact :-)
> Will check.

It isn't that far from pci_map_single() and friends.
See Documentation/DMA-mapping.txt for more details and drivers/net/ for examples
of use.

--
Ueimor
