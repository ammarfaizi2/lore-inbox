Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291443AbSBMHt5>; Wed, 13 Feb 2002 02:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291446AbSBMHtr>; Wed, 13 Feb 2002 02:49:47 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:39695 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S291443AbSBMHth>; Wed, 13 Feb 2002 02:49:37 -0500
Subject: Re: 2.5.4 sound module problem
From: Miles Lane <miles@megapathdsl.net>
To: alan@clueserver.org
Cc: John Weber <john.weber@linuxhq.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200202130752.g1D7qDL22868@clueserver.org>
In-Reply-To: <fa.f4gi5iv.1ikenrc@ifi.uio.no> <fa.fo94urv.167g1q5@ifi.uio.no>
	<3C69F385.5050207@linuxhq.com>  <200202130752.g1D7qDL22868@clueserver.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 12 Feb 2002 23:46:13 -0800
Message-Id: <1013586374.412.1.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-12 at 21:18, Alan wrote:
> On Tuesday 12 February 2002 21:03, John Weber wrote:

<snip>

> > This is correct.  It has been a policy to use pci_alloc_consistent
> > instead of kmalloc/getfreepages and virt_to_bus, 2.5 is enforcing it now.
> 
> By breaking sound (in dmabuf and sound modules), cardbus (lots of places), 
> and who knows what else.
> 
> "grep -r virt_to_bus | less" shows jut how bad it is going to be...

I checked, there are 1069 occurrences.

	Miles

