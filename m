Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbUKEBDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbUKEBDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbUKEBAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:00:37 -0500
Received: from ozlabs.org ([203.10.76.45]:23451 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262529AbUKEA66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:58:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16778.51715.549626.146658@cargo.ozlabs.ibm.com>
Date: Fri, 5 Nov 2004 11:32:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.10-rc1] Add __KERNEL__ to <linux/crc-ccitt.h>
In-Reply-To: <20041104173712.GA13456@smtp.west.cox.net>
References: <20041104173712.GA13456@smtp.west.cox.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:

> Hello.  The following adds a __KERNEL__ check to <linux/crc-ccitt.h>.
> The problem is that the ppp package includes <linux/ppp_defs.h> via
> <net/ppp_defs.h>, which in turn gets <linux/crc-ccitt.h>.

By "the ppp package" do you mean my pppd or someone else's package?  I
though I had my version using a local copy of the necessary headers.

Paul.
