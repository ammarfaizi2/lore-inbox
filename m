Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWGMRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWGMRAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWGMRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:00:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45068 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030247AbWGMRAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:00:50 -0400
Date: Thu, 13 Jul 2006 18:00:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]drivers: returning proper error from serial driver
Message-ID: <20060713170040.GB8376@flint.arm.linux.org.uk>
Mail-Followup-To: Ram Gupta <ram.gupta5@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	linux mailing-list <linux-kernel@vger.kernel.org>
References: <728201270607130945y30dbd388o76725b8a6fe28e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728201270607130945y30dbd388o76725b8a6fe28e56@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 11:45:11AM -0500, Ram Gupta wrote:
> This patch fixes the issue of returning 0 even in case of error from
> uart_set_info function.
> Now it returns the  error EBUSY  when it can not set new port. Please apply
> 
> Signed-off-by: Ram Gupta(r.gupta@astronautics.com)

That should be:

Signed-off-by: Ram Gupta <r.gupta@astronautics.com>

and please don't base64 encode patches - it makes applying them
quite difficult with automated tools.  Please resend as per
Documentation/SubmittingPatches, especially section 6.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
