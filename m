Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVHLTnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVHLTnX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVHLTnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:43:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15630 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751262AbVHLTnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:43:21 -0400
Date: Fri, 12 Aug 2005 20:43:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 11/39] remap_file_pages protection support: add MAP_NOINHERIT flag
Message-ID: <20050812204315.B21152@flint.arm.linux.org.uk>
Mail-Followup-To: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net
References: <20050812182123.C896324E7DD@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812182123.C896324E7DD@zion.home.lan>; from blaisorblade@yahoo.it on Fri, Aug 12, 2005 at 08:21:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:21:23PM +0200, blaisorblade@yahoo.it wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Add the MAP_NOINHERIT flag to arch headers, for use with remap-file-pages.

Does this mean ARM will break when these patches are merged?

> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>  linux-2.6.git-paolo/include/asm-i386/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-ia64/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-ppc/mman.h    |    1 +
>  linux-2.6.git-paolo/include/asm-ppc64/mman.h  |    1 +
>  linux-2.6.git-paolo/include/asm-s390/mman.h   |    1 +
>  linux-2.6.git-paolo/include/asm-x86_64/mman.h |    1 +
>  6 files changed, 6 insertions(+)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
