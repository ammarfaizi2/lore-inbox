Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTAOGvG>; Wed, 15 Jan 2003 01:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTAOGvF>; Wed, 15 Jan 2003 01:51:05 -0500
Received: from dp.samba.org ([66.70.73.150]:40390 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265667AbTAOGvE>;
	Wed, 15 Jan 2003 01:51:04 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-reply-to: Your message of "Mon, 13 Jan 2003 22:19:21 CDT."
             <20030114031921.GD404@gtf.org> 
Date: Wed, 15 Jan 2003 17:45:13 +1100
Message-Id: <20030115065959.4DA742C26F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030114031921.GD404@gtf.org> you write:
> Poo -- why not store the length in a temp, since the compiler does it
> behind the scenes anyway, and then memcpy instead of strcpy?

Apathy, mainly.  There's a mild preference for using string functions
on strings, but...  Naah, mainly it's pure lack of caring.

Hope that helps,
Rusty.
PS.  If your apathy is less than mine, please submit replacement patch
     to trivial.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
