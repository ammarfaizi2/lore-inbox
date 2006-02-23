Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWBWTbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWBWTbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWBWTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:31:24 -0500
Received: from ns.suse.de ([195.135.220.2]:46485 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751518AbWBWTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:31:23 -0500
From: Andi Kleen <ak@suse.de>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 20:31:02 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl>
In-Reply-To: <43FE0B9A.40209@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602232031.03201.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 20:23, Rene Herman wrote:
> Linus Torvalds wrote:
> 
> > The same should be true on x86, btw. Where we should use a physical start 
> > address of 4MB for best performance.
> 
> Does 16MB still work? Gets the kernel out of the old ZONE_DMA. I suppose 
> not many people are really using that anyway anymore these days, but if 
> no downsides maybe?

That would prevent booting on < 18MB or so
> 
> Also, did the kernel still boot on a 4M machine, and would it still do 
> so with the change to 4M as posted? 2.4 used to boot fine with 4M. Not 
> certain anymore if I ever tested that with 2.6 (and can't right now).

It wouldn't without additional changes.

-Andi

