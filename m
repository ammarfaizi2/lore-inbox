Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVG0Jua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVG0Jua (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVG0Jua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:50:30 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:21510 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262086AbVG0Ju1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:50:27 -0400
Date: Wed, 27 Jul 2005 10:50:29 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: johsc@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 panics on boot on 486 box: TSC requires pentium
In-Reply-To: <20050726233647.GU8907@alpha.home.local>
Message-ID: <Pine.LNX.4.61L.0507271046160.13819@blysk.ds.pg.gda.pl>
References: <20050726182258.GA1719@localhost> <20050726233647.GU8907@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Willy Tarreau wrote:

> Seems to me that it simply disables use of TSC. But if you see this option,
> it means that your kernel has been compiled with SMP enabled, which is not
> possible on 486 (I may be wrong here). Most probably, you took a config from
> an inadequate kernel for your machine.

 We do support SMP on Intel MP compliant 486 systems, i.e. as long as they 
are based on the APIC architecture and have a correct MP-table.  This 
might have not been tested for long if at all, though.

  Maciej
