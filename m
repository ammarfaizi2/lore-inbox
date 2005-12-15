Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVLOPge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVLOPge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 10:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVLOPge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 10:36:34 -0500
Received: from mail.suse.de ([195.135.220.2]:15288 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750769AbVLOPge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 10:36:34 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.15-rc5-mm3
References: <20051214234016.0112a86e.akpm@osdl.org>
	<p733bku8zde.fsf@verdi.suse.de>
From: Andi Kleen <ak@suse.de>
Date: 15 Dec 2005 16:36:32 +0100
In-Reply-To: <p733bku8zde.fsf@verdi.suse.de>
Message-ID: <p731x0efk3j.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:
> 
> I have some bad problems on one of my machines (NForce4) with iommu=force and
> SLAB_DEBUG - forcedeth seems to corrupt memory badly then.
> Also now I managed to get the machine into a state where it would
> hang in the SATA driver after boot. Still investigating.

The SATA problem went away mysteriously - probably was a broken
build tree or similar.

Forcedeth issue is still there.
-Andi
