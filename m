Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUKKSxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUKKSxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbUKKSxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:53:14 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:34538 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262321AbUKKRXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:23:17 -0500
Date: Thu, 11 Nov 2004 09:22:21 -0800
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@google.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111172221.GB18538@kroah.com>
References: <20041111044809.GE19615@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111044809.GE19615@google.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 08:48:09PM -0800, Tim Hockin wrote:
> The current PCI probe code breaks for 64 bit BARs that do not decode a
> full 64 bits.  Example:
> 
> We have a device that uses a 64 bit BAR.  When you write all Fs to the
> BARs, you get:
> 
> 	000000ff ffff0000
> 
> It wants 64k, in the first TB of RAM.  The current code totally borks on
> this.
> 
> Simple patch against 2.6.9:

As Andrew pointed out, you didn't even compile test this patch, not nice.

thanks,

greg k-h
