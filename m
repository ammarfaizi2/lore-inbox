Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTD3PjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbTD3PjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:39:06 -0400
Received: from havoc.daloft.com ([64.213.145.173]:39383 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262324AbTD3PjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:39:04 -0400
Date: Wed, 30 Apr 2003 11:51:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] tg3/pci issue with recent 2.5 bk
Message-ID: <20030430155125.GF25076@gtf.org>
References: <Mutt.LNX.4.44.0305010124570.18529-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0305010124570.18529-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 01:44:15AM +1000, James Morris wrote:
> Below are lspci -vvvx outputs for the stock 2.5.68 kernel, in which the 
> driver loads ok, and recent (i.e. within hours) bk, which has the problem.
> 
> The difference between the two is for the PCI bridge, which is missing the 
> following lines in the output for the bk kernel.
> 
>   Memory behind bridge: fff00000-000fffff
>   Prefetchable memory behind bridge: fff00000-000fffff
> 
> Any hints/suggestions/fixes appreciated.

hmmmm.  Can you look through the 2.5.68 PCI-related csets to see if
anything pops up that looks like it's messing with PCI bridge
configuration?

	Jeff



