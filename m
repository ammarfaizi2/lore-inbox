Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271196AbTGWSI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTGWSI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:08:56 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:62458 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271196AbTGWSIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:08:50 -0400
Subject: Re: compact flash IDE hot-swap summary please
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Lawrence <dgl@integrinautics.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1ECFDD.D561D861@integrinautics.com>
References: <3F1ECFDD.D561D861@integrinautics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 19:18:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 19:11, Dave Lawrence wrote:
> I have a Zaurus handheld that runs Linux that seems 
> to be able to hot-swap its IDE compact flash device
> with no problems.  But I've read in a recent
> thread "hdparm and removable IDE?" that hot-swap
> isn't "fully" supported and that is won't be
> until:

Thats hot swapping an IDE controller (built into the CF and
PCMCIA stuff)

Drive level hotswap is supported only in the "I unmounted it all
properly first" case and providing your system has the required bus
isolation. Typically its also only allowed in IDE if you have a
single disk on the channel. With dual device you tend to have nasty
accidents pulling something out while the other device is "live"


