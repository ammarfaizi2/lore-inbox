Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVEKVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVEKVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEKVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:47:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52748 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261329AbVEKVrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:47:19 -0400
Date: Wed, 11 May 2005 22:47:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: arm: Inconsistent kallsyms data
Message-ID: <20050511224713.A16229@flint.arm.linux.org.uk>
Mail-Followup-To: Imre Deak <imre.deak@nokia.com>,
	linux-kernel@vger.kernel.org, kaos@ocs.com.au
References: <1115802310.9757.20.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1115802310.9757.20.camel@mammoth.research.nokia.com>; from imre.deak@nokia.com on Wed, May 11, 2005 at 12:05:10PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:05:10PM +0300, Imre Deak wrote:
> I noticed that the error is triggered by an __initdata definition. It is
> accessed only from an __init function, so that's ok I think. Removing
> the __initdata attribute gets rid of the error message.

This sounds very vague.  Can you show us the code please?

Note that uninitialised variables with an __initdata marking aren't
legal.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
