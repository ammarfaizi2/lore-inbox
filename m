Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTEFBQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTEFBQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:16:14 -0400
Received: from dp.samba.org ([66.70.73.150]:5585 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262222AbTEFBQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:16:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bob Miller <rem@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.68] Convert elan-104nc to remove check_region(). 
In-reply-to: Your message of "Mon, 05 May 2003 10:01:18 MST."
             <20030505170118.GA17276@doc.pdx.osdl.net> 
Date: Tue, 06 May 2003 11:04:34 +1000
Message-Id: <20030506012846.0C6BF2C5C6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030505170118.GA17276@doc.pdx.osdl.net> you write:
> All the request_region() calls in this driver (plus all the now removed
> check_region()) calls are commented out because of conflicts with the PIC.
> 
> The release_region() call below was NOT commented out.  If the driver
> isn't really requsting the region it shouldn't be release it.  So, I
> commented it out.

OK, agreed.  I've replaced the original comment with the one above,
which is more appropriate.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
