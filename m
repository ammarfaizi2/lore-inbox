Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVFPCDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVFPCDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 22:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVFPCDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 22:03:47 -0400
Received: from colin.muc.de ([193.149.48.1]:520 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261704AbVFPCCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 22:02:49 -0400
Date: 16 Jun 2005 04:02:47 +0200
Date: Thu, 16 Jun 2005 04:02:47 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Tracking a bug in x86-64
Message-ID: <20050616020247.GA27608@muc.de>
References: <200506132259.22151.bonganilinux@mweb.co.za> <200506160020.21688.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506151536000.8487@ppc970.osdl.org> <200506160139.04389.bonganilinux@mweb.co.za> <Pine.LNX.4.58.0506151740110.8487@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506151740110.8487@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (It would be even better to see that for one of the processes that tends 
> to core-dump, like "cc1", but that would require you to catch it, probably 
> by doign ^Z at just the right time)

iirc gdb can extract that information from a core dump.
if not readelf -a probably can. 

-Andi
