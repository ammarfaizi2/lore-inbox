Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUA0Mpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUA0Mpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:45:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4114 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263523AbUA0Mpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:45:44 -0500
Date: Tue, 27 Jan 2004 12:45:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Angelo Dell'Aera" <buffer@antifork.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-Net <linux-net@vger.kernel.org>
Subject: Re: airo_cs problem - kernel 2.6.1
Message-ID: <20040127124538.E18409@flint.arm.linux.org.uk>
Mail-Followup-To: Angelo Dell'Aera <buffer@antifork.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-Net <linux-net@vger.kernel.org>
References: <20040127130709.50a3eaae.buffer@antifork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040127130709.50a3eaae.buffer@antifork.org>; from buffer@antifork.org on Tue, Jan 27, 2004 at 01:07:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 01:07:09PM +0100, Angelo Dell'Aera wrote:
> Today I experienced this problem with a Cisco Aironet 350.
> I just want to point out it's the first time it happens. 
> In fact, I still used this NIC on this kernel (2.6.1) without 
> any kind of problem. Attached is an extract from my log.

				AAARRRGGGHHH.

Whatever, it's a known problem with a history of at about three months.
The last message seems to be the maintainer saying that he has a patch
ready and will send to Jeff.  I've no idea if that actually happened or
not.

I'm going to suggest that it gets marked as a broken and unmaintained
driver, or I'm going to bypass the maintainers and submit an _untested_
fix directly to Andrew/Linus.  I don't want to do either, but...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
