Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUHTBvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUHTBvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 21:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUHTBvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 21:51:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265148AbUHTBvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 21:51:45 -0400
Date: Thu, 19 Aug 2004 21:50:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820005019.GB6374@logos.cnet>
References: <20040819014204.2d412e9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm2/
> 
> - Added Tony Luck's ia64 devel tree to the -mm "external trees" lineup.
> 
> - The monster memory leak which some people were seeing with audio CD

Hi Andrew,

Just annoying your arse, I get this:

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xa1bde): In function `radeon_match_mode':
: undefined reference to `vesa_modes'
drivers/built-in.o(.text+0xa1cbd): In function `radeon_match_mode':
: undefined reference to `vesa_modes'
make: ** [.tmp_vmlinux1] Erro 1

Known already?
