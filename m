Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVBHLzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVBHLzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 06:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVBHLzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 06:55:46 -0500
Received: from one.firstfloor.org ([213.235.205.2]:21741 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261517AbVBHLzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 06:55:43 -0500
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PCI Error reporting & recovery
References: <1107835865.7687.78.camel@gaston>
	<420876DC.3040201@jp.fujitsu.com>
From: Andi Kleen <ak@muc.de>
Date: Tue, 08 Feb 2005 12:55:41 +0100
In-Reply-To: <420876DC.3040201@jp.fujitsu.com> (Hidetoshi Seto's message of
 "Tue, 08 Feb 2005 17:22:52 +0900")
Message-ID: <m1is531d1e.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com> writes:
>
> It goes slowly but steadily...
> I'd also like to start the discussion about PCI error reporting again.

It's much more interesting now than it used to be because PCI-Express
is now mainstream and it has standard registers to report errors.

Whatever is adopted should definitely try to handle this.

Unfortunately no standardized exceptions, but at least some Opteron
chipsets can raise NMIs in this case when programmed right.

-Andi
