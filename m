Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752145AbWCJGld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbWCJGld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 01:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWCJGld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 01:41:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:38032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752110AbWCJGlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 01:41:15 -0500
Date: Thu, 9 Mar 2006 22:38:36 -0800
From: Greg KH <gregkh@suse.de>
To: Philip Langdale <philipl@mail.utexas.edu>
Cc: bjdouma@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch
Message-ID: <20060310063836.GA31213@suse.de>
References: <4410F1B7.80302@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410F1B7.80302@mail.utexas.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 07:25:43PM -0800, Philip Langdale wrote:
> Saw this patch mentioned in passing and I wanted to point out
> that this is a more general problem than just for asus motherboards.
> I have a soyo kt880 based dragon 2 motherboard and it exhibits the
> same behaviour and the same fix works (modulo looking for a different
> subsystem vendor - soyo apparently don't have their own id - it's
> set to VIA for all devices). And I've read about it affecting other
> motherboards - I think it must be something that's present in the
> reference BIOS that all the manufacturers use.
> 
> I'm not sure what the most efficient way to generalise it - especially
> with cases like the Soyo one where there's no proper subvendor id.

Great, thanks for the information.  How about just adding new device ids
for the new machines that also need this function called.  It's quite
easy to do that...

thanks,

greg k-h
