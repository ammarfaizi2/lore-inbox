Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWHPPmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWHPPmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWHPPmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:42:05 -0400
Received: from vena.lwn.net ([206.168.112.25]:58271 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932079AbWHPPmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:42:04 -0400
Message-ID: <20060816154204.28656.qmail@lwn.net>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop second arg of unregister_chrdev() 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 16 Aug 2006 09:03:19 +0200."
             <200608160903.25145.eike-kernel@sf-tec.de> 
Date: Wed, 16 Aug 2006 09:42:04 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> > Might this, instead, be an opportunity to get rid of the internal
> > register_chrdev() and unregister_chrdev() calls in favor of the cdev
> > interface?
> 
> In this case I would suggest to add documentation to this functions first to 
> get people the chance to actually know how to use them.

Good point.  My article (http://lwn.net/Articles/49684/) has been
somewhat overtaken by time, though I do think that the discussion in
LDD3 is still applicable.  I'll see what I can do about that side of
things.

jon
