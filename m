Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTKIWww (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 17:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTKIWww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 17:52:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:38120 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261151AbTKIWwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 17:52:51 -0500
Date: Sun, 9 Nov 2003 14:50:28 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, colin@colino.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 : cdc_acm problem
Message-ID: <20031109225027.GA2425@kroah.com>
References: <3FAE77B7.8040901@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAE77B7.8040901@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 09:21:59AM -0800, David Brownell wrote:
> The problem is that cdc_acm calls a "softirq-only" routine
> in a hardirq context.  See this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106764585001038&w=2
> 
> It's not clear that'll make it into 2.6.0-final.

I've not planned to submit it for 2.6.0 as it's a relativly big change,
and I don't have the hardware to test it out.  Anyone have any other
thoughts about this?

thanks,

greg k-h
