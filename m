Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTHWRaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbTHWRaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:30:04 -0400
Received: from AMarseille-201-1-3-186.w193-253.abo.wanadoo.fr ([193.253.250.186]:4136
	"EHLO gaston") by vger.kernel.org with ESMTP id S264300AbTHWR3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 13:29:39 -0400
Subject: Re: PCI PM & compatibility
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030823180815.A1158@flint.arm.linux.org.uk>
References: <1061649597.780.4.camel@gaston>
	 <20030823180815.A1158@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061659704.769.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 19:28:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 19:08, Russell King wrote:
> On Sat, Aug 23, 2003 at 04:39:57PM +0200, Benjamin Herrenschmidt wrote:
> > What about this patch to stay compatible with existing drivers
> > implementing everything in save_state ?
> 
> And why are we now suspending device parents before their siblings???

I didn't notice that on the laptop here (because it's actually harmless
on this specific machine), but if this is the case, then we are badly
wrong indeed...

Ben.

