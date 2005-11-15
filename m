Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVKONk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVKONk0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVKONk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:40:26 -0500
Received: from colin.muc.de ([193.149.48.1]:46866 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932524AbVKONkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:40:25 -0500
Date: 15 Nov 2005 14:40:22 +0100
Date: Tue, 15 Nov 2005 14:40:22 +0100
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: eranian@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, paulus@samba.org, stephane.eranian@hp.com,
       tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-ID: <20051115134022.GB87706@muc.de>
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net> <200511150050.27556.arnd@arndb.de> <20051114171226.680cddc8.akpm@osdl.org> <20051115080055.GA24236@frankl.hpl.hp.com> <1132042089.2822.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132042089.2822.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ... which is a binary only, proprietary application.

The IA32 emulation part of it is actually shipped in source. 
Somehow they manage to link a binary only object to it though.

> 
> Either way, either the emulation is in the kernel or it's not. If it's
> there (like it is now) it deserves maintenance. If it's not, it should
> be removed from the tree, since the only thing it's otherwise good for
> is potential security holes.

I suppose it's still useful for all current IA64 users (Montecito
is not shipping yet and older CPUs support x86 in hardware) who don't like 
binary only software.

-Andi
> 
