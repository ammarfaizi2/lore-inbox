Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbULCP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbULCP1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbULCP1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 10:27:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22221 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262263AbULCP1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 10:27:48 -0500
Subject: Re: How to understand flow of kernel code
From: Josh Boyer <jdub@us.ibm.com>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41B081AE.3000509@globaledgesoft.com>
References: <41B081AE.3000509@globaledgesoft.com>
Content-Type: text/plain
Message-Id: <1102087667.28352.12.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Dec 2004 09:27:47 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-03 at 09:09, krishna wrote:
> Hi Elladan,
> 
>     Thank you very much.
>     Can u tell me how can I start from an interrupt.

Look for the do_IRQ function.  Figure out how it's called, then figure
out what it does, and then figure out how the system is restored.  And
it's a bit more than just C code, so you'll need some understanding of
assembly for whichever architecture you're interested in.

Good luck.

josh

