Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWBOMk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWBOMk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945920AbWBOMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:40:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52744 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1945918AbWBOMk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:40:28 -0500
Date: Wed, 15 Feb 2006 12:40:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFT/PATCH] 3c509: use proper suspend/resume API
Message-ID: <20060215124020.GA1508@flint.arm.linux.org.uk>
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <1139935173.22151.2.camel@localhost> <20060215022523.1d21b9c9.akpm@osdl.org> <Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602151317110.14223@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:23:19PM +0200, Pekka J Enberg wrote:
> Hmm. Either I am totally confused or we don't even attempt suspend/resume 
> for eisa and mca bus devices. Care to try this patch?

Please don't use struct device_driver suspend/resume methods.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
