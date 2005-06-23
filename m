Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVFWV2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVFWV2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVFWV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:28:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38923 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262769AbVFWV1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:27:32 -0400
Date: Thu, 23 Jun 2005 22:27:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PATCH] Serial updates
Message-ID: <20050623222728.C12573@flint.arm.linux.org.uk>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20050623193304.GA15536@dyn-67.arm.linux.org.uk> <42BB2027.3090800@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42BB2027.3090800@didntduck.org>; from bgerst@didntduck.org on Thu, Jun 23, 2005 at 04:48:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 04:48:39PM -0400, Brian Gerst wrote:
> Russell King wrote:
> > +
> > +		if (up->capabilities & UART_BUG_TXEN) {
> 
> Shouldn't this be up->bugs?

Whoops, thanks for spotting that, Brian.  Fixed in all places.
(Guess who forgot to update one of the patches...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
