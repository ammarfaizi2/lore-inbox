Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVCITLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVCITLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVCITLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:11:47 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:9234 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262338AbVCITJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:09:32 -0500
Date: Wed, 9 Mar 2005 20:09:20 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050309190920.GA4044@pclin040.win.tue.nl>
References: <200503081937.j28Jb4Vd020597@hera.kernel.org> <1110387326.28860.199.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110387326.28860.199.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 04:55:27PM +0000, Alan Cox wrote:

> > 	[PATCH] remove dead cyrix/centaur mtrr init code
> 
> This patch was discussed previously and declared incorrect. The ->init
> method call is missing in the base mtrr code.
> 
> Should be reverted and/or fixed properly.

Hi Alan - a surprising reaction.

The patch is an improvement - it #ifdef's out some dead code.
I sent you a follow-up patch that activates the dead code,
since you said

  I have one here running 2.4 still. I can test a 2.6 fix
  for the mtrr init happily enough.

But so far you have not replied.
The moment you report that the follow-up patch is fine, we can
remove the #if 0 and insert the initcalls instead.

So, all is well today, and we are waiting for your report.

Andries
