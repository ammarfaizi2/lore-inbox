Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTH2NVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbTH2NVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:21:54 -0400
Received: from mta6-svc.business.ntl.com ([62.253.164.46]:46542 "EHLO
	mta6-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S261167AbTH2NVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:21:50 -0400
Date: Fri, 29 Aug 2003 14:23:51 +0100 (BST)
From: William Gallafent <william@gallaf.net>
X-X-Sender: williamg@officebedroom.oldvicarage
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stable mainboard for Athlon/IDE
In-Reply-To: <87r834isbi.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.53.0308291416470.5872@officebedroom.oldvicarage>
References: <87r834isbi.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003, Florian Weimer wrote:

> AMD 761 based boards (which were recommended to me) don't seem to be
> available anymore, at least from our local suppliers.

Well, for dual-processor systems you can still get the AMD 760 chipsets,
because nobody else made a DP chipset for Athlon (that I know of!). I run
software-raid-0 over two ATA drives on a Tyan S2460 (tiger MP) which has the
AMD 760MP chipset. This works very well. There is a slightly more expensive
version, the S2466, which uses the 760MPX chipset. Both are still available,
as are boards from several other manufacturers using the same chipsets. The
onboard IDE on AMD760MP supports speeds up to ATA-100 and seems to be rock
solid under Linux.

I and others have had problems which may relate to interactions between AMD
760MP(X) chipset and Promise PCI ATA (e.g. Ultra133-TX2) controllers, with
machine lockups and data corruption when there is a heavy PCI load, so this
combination may be best avoided.

> Or should I ditch AMD and buy Intel instead?

Could do ... depends how deep your pockets are and what you will be using the
server for I suppose.

-- 
Bill Gallafent.
