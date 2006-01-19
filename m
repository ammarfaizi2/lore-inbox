Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWASGbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWASGbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWASGbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:31:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932569AbWASGbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:31:05 -0500
Date: Wed, 18 Jan 2006 22:30:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
 removed from -mm tree
Message-Id: <20060118223039.1d9dfe64.akpm@osdl.org>
In-Reply-To: <20060119171708.7f856b42.sfr@canb.auug.org.au>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	<1137648119.30084.94.camel@localhost.localdomain>
	<20060119171708.7f856b42.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Documentation/CodingStyle says:
> 
>  The limit on the length of lines is 80 columns and this is a hard limit.
> 
>  Statements longer than 80 columns will be broken into sensible chunks.
>  Descendants are always substantially shorter than the parent and are placed
>  substantially to the right. The same applies to function headers with a long
>  argument list. Long strings are as well broken into shorter strings.

That's pretty stern.

I'd be happy with a 96-col standard, or 100 or whatever - it's more
convenient and I use twin 20" guns.  But other people have different
hardware constraints and different work practices, so they want 80 cols. 
If we're going to get down and change the standard then OK, let's have that
bunfight.  But while there's a standard we should stick to it so we don't
screw over the people who like to use standard-sized xterms.

And yes, some editors can do sideways-scrolling to make wider-than-80
acceptable in an 80-col window.  But other people's setups don't do that,
and the cost to those people of wrappy code is higher than the cost of
looking at standardly-laid-out code to fancy-editor users.

So the lowest common denominator wins, because they hurt more than anyone
else if we go outside 80-cols.  I use 80-col xterms precisely for this
reason: so that the code which goes in will look OK to those users.
