Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbTDWQMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTDWQMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:12:08 -0400
Received: from almesberger.net ([63.105.73.239]:517 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id S264102AbTDWQMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:12:02 -0400
Date: Wed, 23 Apr 2003 13:23:59 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Robert Love <rml@tech9.net>
Cc: Julien Oster <frodo@dereference.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030423132359.B3557@almesberger.net>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net> <1051113589.707.948.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051113589.707.948.camel@localhost>; from rml@tech9.net on Wed, Apr 23, 2003 at 11:59:49AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> Why on earth would the user give the kernel a password?

That's just an example. It could be any other sensitive information,
including kernel state that you don't want to reveal to users.

I think it's a reasonable assumption that one can speak freely in a
printk message. Avoiding to print anything that may possibly contain
sensitive information is likely to make messages less useful, just
think of all the data revealed in an oops.

> The point is user input like telephone numbers or passwords should never
> be fed into the kernel anyhow.

Yes, a bit odd. Maybe because of "intelligent" cards that implement
the signalling in firmware. Anyway, this is an entirely different
issue.
 
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
