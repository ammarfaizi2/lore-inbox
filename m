Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137048AbREKFbM>; Fri, 11 May 2001 01:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137049AbREKFbE>; Fri, 11 May 2001 01:31:04 -0400
Received: from [203.143.19.4] ([203.143.19.4]:12305 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S137050AbREKFaz>;
	Fri, 11 May 2001 01:30:55 -0400
Date: Thu, 10 May 2001 17:58:21 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Duncan Gauld <duncan@gauldd.freeserve.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Possible README patch
In-Reply-To: <20010505102133.A16788@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0105101754080.283-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 May 2001, Russell King wrote:

> gzip -dc linux-2.4.XX.tar.gz | tar zvf -
> gzip -dc patchXX.gz | patch -p0

This does _not_ work for international kernel patch. They assume the
directories lin.2.x.x/ (old) and int.2.x.x/ (new) and not linux/.
Therefore it _is_ necessary to `cd linux' and do a `patch -p1'.

Anuradha


----------------------------------------------------------
<a href="http://www.bee.lk/people/anuradha/">home page</a>


