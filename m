Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTELGZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 02:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTELGZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 02:25:29 -0400
Received: from dp.samba.org ([66.70.73.150]:26784 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261956AbTELGZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 02:25:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Jeremy Jackson" <jerj@coplanar.net>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Cc: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique. 
In-reply-to: Your message of "Sun, 11 May 2003 21:49:53 -0400."
             <003f01c31828$c8e9f480$7c07a8c0@kennet.coplanar.net> 
Date: Mon, 12 May 2003 16:37:29 +1000
Message-Id: <20030512063812.EEDAF2C0F5@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <003f01c31828$c8e9f480$7c07a8c0@kennet.coplanar.net> you write:
> Cool stuff.
> 
> As far as making the parameters easy to parse, I think you would want to
> have a single static tag before the = (equal) sign.  The kernel command line
> parsing stuff provides parsing up to that point and dispatches to each
> subsystem (or at least it used to), so:
> 
> ata.dev_noprobe=hda
> 
> should be
> 
> ata=dev_noprobe:hda,if_io_irq:0,0x1f0,7
> 
> or some such to use the generic code that's already there.

Sure, some more complex generic parsing thing certainly makes sense.
I think whoever produces the code will probably get to decide what it
looks like.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
