Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTH2LRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTH2LRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:17:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53261 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264527AbTH2LRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:17:42 -0400
Date: Fri, 29 Aug 2003 12:17:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829121738.A23774@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk.suse.lists.linux.kernel> <p733cfkpvp8.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p733cfkpvp8.fsf@oldwotan.suse.de>; from ak@suse.de on Fri, Aug 29, 2003 at 01:08:51PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 01:08:51PM +0200, Andi Kleen wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> > data cache is 64k.  (The explanation is easy: virtually indexed,
> > physically tagged cache moves data among cache lines, possibly via L2).
> 
> On x86 L2 is usually physically tagged.
> 
> Mostly only ARM,MIPS et.al. have virtually tagged L2.

Correction: ARM L1 is mostly VIVT.  L2 cache isn't mandated by the
architecture, and therefore generally doesn't exist.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

