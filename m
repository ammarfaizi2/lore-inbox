Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUHUWMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUHUWMA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 18:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267955AbUHUWL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 18:11:59 -0400
Received: from gate.ebshome.net ([66.92.248.57]:10149 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S267963AbUHUWLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 18:11:43 -0400
Date: Sat, 21 Aug 2004 15:11:41 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "David N. Welton" <davidw@dedasys.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
Message-ID: <20040821221140.GA24479@gate.ebshome.net>
Mail-Followup-To: "David N. Welton" <davidw@dedasys.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1092569364.9539.16.camel@gaston> <873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston> <87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com> <1092729140.9539.129.camel@gaston> <87k6vytbjo.fsf@dedasys.com> <1092732749.10506.151.camel@gaston> <87isbh6hxd.fsf@dedasys.com> <871xi0te7o.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xi0te7o.fsf@dedasys.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 10:42:51PM +0200, David N. Welton wrote:
> The only thing that jumps out at me is that arch/ppc/mm/cachemap.c
> 'moved' to arch/ppc/kernel/dma-mapping.c and seems to have changed
> some as well. 

dma-mapping.c is used only on non-coherent cache CPUs (like 4xx, 8xx). 
It's not relevant and is not even compiled for powermacs.

Eugene


