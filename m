Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbVJMSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbVJMSqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbVJMSqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:46:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751601AbVJMSqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:46:34 -0400
Date: Thu, 13 Oct 2005 11:46:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] drivers/base - fix sparse warnings
In-Reply-To: <20051013182154.GB24367@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0510131145030.15297@g5.osdl.org>
References: <20051013165441.GA18360@home.fluff.org>
 <Pine.LNX.4.64.0510131059510.15297@g5.osdl.org> <20051013182154.GB24367@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Oct 2005, Russell King wrote:
> 
> Erm, lets take your example - attribute_container_init().  It's defined
> in attribute_container.c, where the base.h include was added:
> 
> I can't see anything that was missed.

Duh. My mistake, I looked at the patch twice, but I still missed the place 
where it removed the declaration. Twice.

Gaah. Where are my brain-pills again?

		Linus
