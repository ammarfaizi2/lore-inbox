Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTDIDN7 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTDIDN6 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:13:58 -0400
Received: from dp.samba.org ([66.70.73.150]:24231 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262001AbTDIDN6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 23:13:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SET_MODULE_OWNER? 
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>, sfr@canb.auug.org.au,
       "Nemosoft Unv." <nemosoft@smcc.demon.nl>, davem@redhat.com
In-reply-to: Your message of "Tue, 08 Apr 2003 21:03:00 -0400."
             <3E937144.9090105@pobox.com> 
Date: Wed, 09 Apr 2003 13:23:33 +1000
Message-Id: <20030409032537.547E32C06F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E937144.9090105@pobox.com> you write:
> Why don't you just let the maintainers apply the driver "cleanups" if 
> they wish, or do not wish, like DaveM did.  Only when that is 
> accomplished is it reasonable to consider moving SET_MODULE_OWNER -- and 
> only then if other people do not need it's obvious utility.

The please define when it should and should not be used, so everyone
knows.

Currently it seems to be:

/* This macro should be used on structures which had the owner field
   added between 2.2 and 2.4, and not others. */

Is that correct?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
