Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTDKSZR (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbTDKSZR (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:25:17 -0400
Received: from AMarseille-201-1-6-197.abo.wanadoo.fr ([80.11.137.197]:28711
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261482AbTDKSZQ (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 14:25:16 -0400
Subject: Re: [PATCH] New radeonfb fork
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304111922530.26995-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0304111922530.26995-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050086210.3377.12.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 11 Apr 2003 20:36:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 20:23, James Simmons wrote:
> For the new radeonfb driver will you be switching to DMA mode now that the 
> fbdev can support it?

Not at first. There is already much I can do without that, and that
requires proper setup of the card's internal memory map, which I
want to avoid until I've figured out with ATI how to make that
compatible between radeonfb, XFree/ATI, ATI binary drivers and
GATOS drivers...

I'm more interested, at first, in getting proper monitor detection
& DDC/EDID stuff and dual head & mirorring support.

Ben.

