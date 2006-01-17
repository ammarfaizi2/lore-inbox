Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWAQCki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWAQCki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 21:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWAQCki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 21:40:38 -0500
Received: from [198.99.130.12] ([198.99.130.12]:56495 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751322AbWAQCki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 21:40:38 -0500
Date: Mon, 16 Jan 2006 22:32:27 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 9/11] UML - Implement soft interrupts
Message-ID: <20060117033227.GB17171@ccure.user-mode-linux.org>
References: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org> <200601170124.32076.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170124.32076.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:24:31AM +0100, Blaisorblade wrote:
> ~25 %? Good! Which is delay vs. host?

Delay vs a UML without the patch.

> A curiosity - did you look at the similar code in Ingo Molnar's VCPU patch? 
> I never found the time to split it out and compare differencies. I just 
> remember it using assembler inserts for (maybe atomic) bitmask manipulations.

It was separate from VCPU, but I never really looked at it since I already
had this.  Some day I will to see if there are any trick in it that I should
use.

				Jeff
