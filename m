Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWCFXiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWCFXiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWCFXiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:38:18 -0500
Received: from kanga.kvack.org ([66.96.29.28]:5312 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932475AbWCFXiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:38:18 -0500
Date: Mon, 6 Mar 2006 18:33:00 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Dan Aloni <da-x@monatomic.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Status of AIO
Message-ID: <20060306233300.GR20768@kvack.org>
References: <20060306062402.GA25284@localdomain> <20060306211854.GM20768@kvack.org> <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 02:53:07PM -0800, Ulrich Drepper wrote:
> I don't think the POSIX AIO nor the kernel AIO interfaces are suitable
> for sockets, at least the way we can expect network traffic to be
> handled in the near future.  Some more radical approaches are needed. 
> I'll have some proposals which will be part of the talk I have at OLS.

Oh?  I've always envisioned that network AIO would be able to use O_DIRECT 
style zero copy transmit, and something like I/O AT on the receive side.  
The in kernel API provides a lightweight event mechanism that should work 
ideally for this purpose.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
