Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUFBTsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUFBTsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 15:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUFBTsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 15:48:40 -0400
Received: from colin2.muc.de ([193.149.48.15]:51974 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263962AbUFBTsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 15:48:38 -0400
Date: 2 Jun 2004 21:48:38 +0200
Date: Wed, 2 Jun 2004 21:48:38 +0200
From: Andi Kleen <ak@muc.de>
To: Arthur Perry <kernel@linuxfarms.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: GART Error 11
Message-ID: <20040602194838.GB87771@colin2.muc.de>
References: <22qyw-6e7-29@gated-at.bofh.it> <22ELe-oP-47@gated-at.bofh.it> <m3vfi96drx.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0406021421490.14423@tiamat.perryconsulting.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406021421490.14423@tiamat.perryconsulting.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 02:35:33PM -0400, Arthur Perry wrote:
> Thanks Andi!
> I did not realize there were quirks associated with reading this right from pci config space.
> 
> Perhaps someone can tell me this:
> Does anybody know if there is any documented information about the differences between agp driver version 0.99 and 0.100?
> I know I can just read the source, but there must be list of known bugs and what has been addressed by the newer version, right?

You can read the bitkeeper logs at http://linux.bkbits.net
for the file in question.

Version numbers for kernel subsystems are often meaningless
because there are lots of changes without version number changes.


> The reason why I ask is that both RedHat and SuSE are using 0.99 agp driver still..
> RedHat Enterprise 3.0 's 2.4.21-9.0.1EL kernel and SuSE's 2.4.19 kernel have this in common, and I am seeing such gart errors only with their kernels.

Don't use the 2.4.19 kernel, use the SLES8-SP3 kernel. It will likely
fix this, there was a fix in this area, which also got into 2.4 mainline. 
I don't know about RH kernels.

-Andi
