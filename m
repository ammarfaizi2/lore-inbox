Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVCLTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVCLTQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCLTOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:14:17 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:58266
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S262008AbVCLTOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:14:05 -0500
Date: Sat, 12 Mar 2005 19:13:54 +0000
From: Ben Dooks <ben@fluff.org>
To: "Juan M. de la Torre" <jmtorre@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11 does not handle IRQ #0 on IXP4xx ARM platforms
Message-ID: <20050312191354.GC16590@home.fluff.org>
References: <20050312190358.GA14440@mobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312190358.GA14440@mobile>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2005 at 08:03:58PM +0100, Juan M. de la Torre wrote:
> 
>  The original get_irqnr_and_bse macro leave Z flag set when the IRQ
>  being handled is #0, but the correct behaviour is to clear the flag
>  when there is at least one IRQ to handle.
>  
> PS: Please CC me in the reply because i'm not subscribed to the list

Best talk to the linux-arm-kernel list, which can be found
on http://www.arm.linux.org.uk/

There is also an linux-arm patch tracking system there where
you can submit fixes like that for the Linux/ARM community
to check.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
