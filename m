Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbTILHsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 03:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbTILHsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 03:48:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37391 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261228AbTILHsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 03:48:22 -0400
Date: Fri, 12 Sep 2003 08:48:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual alias cache coherency results (was: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this)
Message-ID: <20030912084818.A19967@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	linux-kernel@vger.kernel.org
References: <20030910210416.GA24258@mail.jlokier.co.uk> <20030910233951.Q30046@flint.arm.linux.org.uk> <20030910233720.GA25756@mail.jlokier.co.uk> <20030911010702.W30046@flint.arm.linux.org.uk> <20030911123535.GB28180@mail.jlokier.co.uk> <20030911160929.A19449@flint.arm.linux.org.uk> <20030911162510.GA29532@mail.jlokier.co.uk> <20030911175224.A20308@flint.arm.linux.org.uk> <20030912004546.GB31860@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030912004546.GB31860@mail.jlokier.co.uk>; from jamie@shareable.org on Fri, Sep 12, 2003 at 01:45:46AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 01:45:46AM +0100, Jamie Lokier wrote:
> > ...until we learn what kernel versions the Netwinder folks are
> > running, or they kindly run the test on a new kernel.
> 
> Two of the Netwinders are running 2.4.19-rmk7-nw1, and one is running
> 2.2.12-19991020.
> 
> Are both of these prior to when alias pages were made uncacheable?

2.2.12 is certainly too old for the fixup.  2.4.19-rmk7 -based kernels
have the fixup.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
