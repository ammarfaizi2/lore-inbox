Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVDMHor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVDMHor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 03:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVDMHor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 03:44:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26383 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262520AbVDMHoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 03:44:32 -0400
Date: Wed, 13 Apr 2005 08:44:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: "akpm@osdl.org" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 006/198] arm: add comment about max_low_pfn/max_pfn
Message-ID: <20050413084427.A1798@flint.arm.linux.org.uk>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@gmail.com>,
	"akpm@osdl.org" <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200504121030.j3CAUie5005135@shell0.pdx.osdl.net> <2cd57c900504122010430af248@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2cd57c900504122010430af248@mail.gmail.com>; from coywolf@gmail.com on Wed, Apr 13, 2005 at 11:10:35AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:10:35AM +0800, Coywolf Qi Hunt wrote:
> I told rmk about this long time ago.

The kernel is a mess of DMA masks and maximum PFNs which all assume
that memory always starts at zero, which I've mentioned before as
well.

I might see about fixing this up properly when it causes real
problems, but until then its better to document the behaviour.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
