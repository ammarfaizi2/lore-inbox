Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUATSpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUATSpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:45:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10464 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265692AbUATSpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:45:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 20 Jan 2004 19:32:59 +0100
From: Gerd Knorr <kraxel@suse.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
Message-ID: <20040120183259.GA23706@bytesex.org>
References: <20040120124626.GA20023@bytesex.org.suse.lists.linux.kernel> <p73n08ihj25.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73n08ihj25.fsf@verdi.suse.de>
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 01:59:46PM +0100, Andi Kleen wrote:
> Gerd Knorr <kraxel@bytesex.org> writes:
> > 
> > +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> > +source "drivers/i2c/Kconfig"
> > +
> 
> There is no such source in arch/i386/Kconfig.  So it's probably wrong.

i386 includes that indirectly via drivers/Kconfig
So should the other archs do that too?

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
