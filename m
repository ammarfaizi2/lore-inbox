Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTERF0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 01:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTERF0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 01:26:55 -0400
Received: from zero.aec.at ([193.170.194.10]:21003 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261970AbTERF0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 01:26:55 -0400
Date: Sun, 18 May 2003 07:39:35 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andi Kleen <ak@muc.de>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030518053935.GA4112@averell>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 10:51:36PM +0200, Alan Cox wrote:
> On Iau, 2003-05-15 at 16:16, Dave Jones wrote:
> > There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
> > we can work around them with a quirk.  I have one *somewhere*, but it'll
> > take me a while to dig it out.
> 
> Some older SiS cards have problems too. I have a 6326 that doesn't work
> with sisfb (too old) and vesafb with mtrr fails.

Can you provide PCI info for them to add a quirk ? 

-Andi
