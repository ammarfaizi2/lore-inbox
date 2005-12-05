Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVLEKQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLEKQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVLEKQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:16:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34062 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750718AbVLEKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:16:24 -0500
Date: Mon, 5 Dec 2005 10:16:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpcore_wdt.c bogus fpos check
Message-ID: <20051205101613.GB8863@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051118160550.GB13943@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118160550.GB13943@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 02:05:50PM -0200, Marcelo Tosatti wrote:
> Has been broken since then... Don't have a device to test - does it work
> at all?

mpcore is a recent addition to the kernel, and this got missed in my
review.  Thanks for spotting, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
