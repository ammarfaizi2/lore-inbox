Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUD1CVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUD1CVO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbUD1CVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:21:14 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64231 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262029AbUD1CVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:21:13 -0400
Date: Tue, 27 Apr 2004 19:18:18 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rusty@rustcorp.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix cpu iterator on empty bitmask
Message-Id: <20040427191818.493d621c.pj@sgi.com>
In-Reply-To: <20040428015703.GX743@holomorphy.com>
References: <1083109972.2150.124.camel@bach>
	<20040428000511.GU743@holomorphy.com>
	<1083115347.30987.202.camel@bach>
	<20040427183135.6250f7bc.pj@sgi.com>
	<20040428015703.GX743@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eh? Why are you now suddenly changing your tune from when I wrote a fix

Rusty said that one fix was causing oopses.  And he caught me in a
weak moment - so I didn't challenge him on that assertion.

Yes I would prefer to limit changes in this code to what's actually
breaking other code here and now.

As soon as I can get the latest 2.6.6-rc2-mm2 to build various
arch's and merge with this stuff, I will be ready to request
Andrew's attention once again.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
