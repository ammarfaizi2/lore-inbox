Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWI1Xaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWI1Xaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWI1Xai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:30:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751128AbWI1Xah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:30:37 -0400
Date: Thu, 28 Sep 2006 16:30:23 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, oe@hentges.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: sky2 (was Re: 2.6.18-mm2)
Message-ID: <20060928163023.21086528@freekitty>
In-Reply-To: <20060928162539.7d565d0a.akpm@osdl.org>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	<451C5599.80402@garzik.org>
	<20060928162539.7d565d0a.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> See also http://bugzilla.kernel.org/show_bug.cgi?id=7222
> 
> That's two reports in 18 hours, from amongst the presumably-small population
> of sky2-owning -mm testers.

I'll back it out if we don't get a simple resolution. It was just trying to
use the pci facilities as intended.

Note: I know what is causing all the sky2 problems, there is something wrong that
is causing flow control negotiation not to propagate back to all the multiple levels
of the chip. Unclear how to fix it, the documentation is not helpful on this.
If not resolved soon, I'll just force Tx flow control off for now.


-- 
Stephen Hemminger <shemminger@osdl.org>
