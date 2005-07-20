Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVGTVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVGTVFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVGTVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 17:05:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14825 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261505AbVGTVFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 17:05:25 -0400
Date: Wed, 20 Jul 2005 14:05:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: mst@mellanox.co.il, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Message-Id: <20050720140515.64bde211.pj@sgi.com>
In-Reply-To: <9a87484905072005596f2c2b51@mail.gmail.com>
References: <20050711145616.GA22936@mellanox.co.il>
	<9a87484905072005596f2c2b51@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 3c. * in types
> >         Leave space between name and * in types.
> >         Multiple * dont need additional space between them.
> > 
> >         struct foo **bar;
> > 
> Don't put spaces between `*' and the name when declaring variables,
> even if it's not a double pointer.   int * foo;  is ugly. Common
> convention is  int *foo;


The "Leave space between name and *" is confusing.  Does 'name'
refer to the type or variable.  I hope Michael was not recommending:

	char * p;

How about saying:

	Do not leave a space between a * and the following
	variable name, nor between multiple *, when used
	to declare pointers:

		char *p;
		struct foo **bar;


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
