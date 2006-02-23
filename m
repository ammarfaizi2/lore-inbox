Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWBWS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWBWS2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWBWS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:28:09 -0500
Received: from ns1.suse.de ([195.135.220.2]:53644 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751211AbWBWS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:28:08 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 19:14:44 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231820.50384.ak@suse.de> <Pine.LNX.4.64.0602230939360.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230939360.3771@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231914.44936.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 18:44, Linus Torvalds wrote:
> 
> On Thu, 23 Feb 2006, Andi Kleen wrote:
> >
> > I was to suggest the same thing originally, but on several boxes I checked
> > there weren't any special MTRRs < 1MB, only in the PCI memory hole
> > <4GB. I suspect there isn't just any interesting hardware in 640K anymore.
> 
> I wasn't talking about the regular MTRR's, but about the magic one: the 
> "Fixed Range MTRRs" that only map the low 1MB.
> 
> I'm pretty sure that they are still used by the BIOS to set up the 
> 640k->1M window.

Ah you're right i forgot that one.

-Andi
