Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCZWxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCZWxv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 17:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVCZWxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 17:53:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6664 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261344AbVCZWxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 17:53:44 -0500
Date: Sat, 26 Mar 2005 22:53:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Bryan O'Donoghue" <typedef@eircom.net>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: arc/arm/config.in still broken 2.4.19-2.4.29 ?
Message-ID: <20050326225341.E23306@flint.arm.linux.org.uk>
Mail-Followup-To: Bryan O'Donoghue <typedef@eircom.net>,
	marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
References: <4245C711.2040304@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4245C711.2040304@eircom.net>; from typedef@eircom.net on Sat, Mar 26, 2005 at 08:33:21PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 08:33:21PM +0000, Bryan O'Donoghue wrote:
> Greetings list.
> 
> arch/arm/config.in has an error which breaks make.
> 
> I've googled this a bit just by searching for drivers/ssi/Config.in and the 
> first reference I find to this breakage is in 2002 !
> 
> For completeness shouldn't this really be removed once and for all?
> 
> I'm not clear on what the procedure is for submitting a patch, but, I've 
> included one to save somebody else the bother.

ARM is not maintained in mainline 2.4 kernels.  It's a dead loss trying to
merge ARM into 2.4 kernels due to many invasive kernel changes.

You need a 2.4-vrs patch on top of mainline 2.4 kernels to make them build
for ARM.  See www.arm.linux.org.uk/developer/ for more information.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
