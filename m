Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWHPE1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWHPE1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 00:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWHPE1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 00:27:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750736AbWHPE1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 00:27:01 -0400
Date: Tue, 15 Aug 2006 21:26:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-Id: <20060815212656.4eb260f3.akpm@osdl.org>
In-Reply-To: <44E28989.1010904@shaw.ca>
References: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no>
	<44E28989.1010904@shaw.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 20:57:13 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> Warnings and an oops on suspend to disk:
> 
> http://www.roberthancock.com/oops1.jpg
> http://www.roberthancock.com/oops2.jpg
> http://www.roberthancock.com/oops3.jpg
> http://www.roberthancock.com/oops4.jpg
> http://www.roberthancock.com/oops5.jpg
> http://www.roberthancock.com/oops6.jpg
> http://www.roberthancock.com/oops7.jpg
> http://www.roberthancock.com/oops8.jpg
> 
> Sleeping function called from invalid context in acpi

Yes.  It appears that we've decided to release 2.6.18 with this feature.

> and kernel NULL 
> pointer dereference in _raw_spin_lock from generic_unplug_device,

Would you be using swap-over-DM?

> with 
> some "DWARF2 unwinder stuck" errors for good measure..

And this one.
