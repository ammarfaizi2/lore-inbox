Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEERiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 13:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbTEERiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 13:38:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:29922 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261218AbTEERiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 13:38:19 -0400
Date: Mon, 5 May 2003 10:50:30 -0700
From: Greg KH <greg@kroah.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-i2c@pelican.tk.uni-linz.ac.at, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: Tyans S2460 hang with i2c
Message-ID: <20030505175030.GB1713@kroah.com>
References: <20030505114246.GA673@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505114246.GA673@gallifrey>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 12:42:46PM +0100, Dr. David Alan Gilbert wrote:
> Kernel: 2.5.69
> Motherboard: Tyan S2460 (Dual Athlon 760MP chipset)
> 
> It works fine without i2c, with i2c we hang directly after:
> 
> i2c /dev entries module version 2.7.0 (20021208)
> registering 0-0048

What i2c drivers are you trying to load?  Are you sure you have the
hardware for them?  Some of the i2c sensor drivers can hang your box if
you load them and you don't have the hardware for them.

And has these i2c drivers ever worked for you before on an older version
of 2.5?

thanks,

greg k-h
