Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbUKEBLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUKEBLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUKEBHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:07:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33018 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262547AbUKEBEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:04:42 -0500
Date: Thu, 4 Nov 2004 18:04:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1] Add __KERNEL__ to <linux/crc-ccitt.h>
Message-ID: <20041105010440.GL13456@smtp.west.cox.net>
References: <20041104173712.GA13456@smtp.west.cox.net> <16778.51715.549626.146658@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16778.51715.549626.146658@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:32:03AM +1100, Paul Mackerras wrote:
> Tom Rini writes:
> 
> > Hello.  The following adds a __KERNEL__ check to <linux/crc-ccitt.h>.
> > The problem is that the ppp package includes <linux/ppp_defs.h> via
> > <net/ppp_defs.h>, which in turn gets <linux/crc-ccitt.h>.
> 
> By "the ppp package" do you mean my pppd or someone else's package?  I
> though I had my version using a local copy of the necessary headers.

ppp_2.4.2+20040202.orig.tar.gz (Debian's ppp_2.4.2+20040202-3).

-- 
Tom Rini
http://gate.crashing.org/~trini/
