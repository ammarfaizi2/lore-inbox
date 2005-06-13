Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFMSmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFMSmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFMSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:40:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26017 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261193AbVFMSjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:39:14 -0400
Date: Mon, 13 Jun 2005 10:42:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31 0/9] gcc4 fixes overview
Message-ID: <20050613134211.GA23160@logos.cnet>
References: <200506121116.j5CBGJPs019683@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506121116.j5CBGJPs019683@harpo.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mikael,

I believe its about time for v2.4 to reject such kind of modifications, 
they can live outside the mainline repository. 

On Sun, Jun 12, 2005 at 01:16:19PM +0200, Mikael Pettersson wrote:
> This set of patches fixes gcc4 problems in the 2.4.31
> kernel's 'core' code. I've been running gcc4-compiled 2.4
> kernels for several months on i386, x86_64, and ppc32, and
> there are currently no known regressions compared to gcc34.
> 
> Note: you'll want to use recent gcc-4.0.1 snapshots as
> gcc-4.0.0 is known to be broken.
> 
> This set of patches do not include fixes to drivers,
> file systems, or architectures I don't use myself. I
> have a preliminary patch kit for those, but as it
> has received only limited compile testing I'm not
> submitting it unless these core patches are accepted.
> 
> The patch set consists of the following 9 parts:
> [1/9] fix incomplete array errors
> [2/9] fix static-vs-nonstatic redefinition errors
> [3/9] fix nested function declaration errors
> [4/9] fix undefined strcpy linkage errors
> [5/9] fix x86_64 acpi assembly error
> [6/9] fix x86_64 sys_iopl() bug
> [7/9] fix const function warnings
> [8/9] silence pointer signedness warnings
> [9/9] fix i386 struct_cpy() warnings
