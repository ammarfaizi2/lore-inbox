Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTESWqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbTESWqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:46:15 -0400
Received: from holomorphy.com ([66.224.33.161]:46057 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263171AbTESWqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:46:13 -0400
Date: Mon, 19 May 2003 15:59:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI mapping on large memory 32-bit machines
Message-ID: <20030519225904.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EC91F3B.8010005@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC91F3B.8010005@techsource.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 02:15:23PM -0400, Timothy Miller wrote:
> On x86 with PAE and 4 gigs of RAM or more, where do memory-mapped I/O 
> devices get mapped (in the physical address space)?  Most PCI devices 
> can't handle 64-bit addresses.  Can PC chipsets physically remap some of 
> the RAM to above 4 gig?  Or do you just lose that much RAM?  If both RAM 
> and some I/O device are mapped to the same location, isn't there a conflict?

AFAIK most (if not all) of that lands below 4GB in extant chipsets/BIOS's.

Remapping above 4GB is possible but various things would probably barf.


-- wli
