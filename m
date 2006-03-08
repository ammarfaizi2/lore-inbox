Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWCHR5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWCHR5H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCHR5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:57:07 -0500
Received: from are.twiddle.net ([64.81.246.98]:39297 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S1751498AbWCHR5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:57:05 -0500
Date: Wed, 8 Mar 2006 09:56:52 -0800
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060308175652.GA28296@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Mathieu Chouquet-Stringer <mchouque@free.fr>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru> <20060306135434.GA12829@localhost> <20060306191324.A1502@jurassic.park.msu.ru> <20060306163142.GA19833@localhost> <20060308142857.A4851@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308142857.A4851@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 02:28:57PM +0300, Ivan Kokshaysky wrote:
>  	irq_enter();
>  	local_irq_disable();
>  	__do_IRQ(irq, regs);
> -	local_irq_enable();
>  	irq_exit();

This will need commenting if it's to go in.


r~
