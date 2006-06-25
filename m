Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWFYRj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWFYRj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWFYRj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:39:59 -0400
Received: from mail.gmx.net ([213.165.64.21]:26293 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932430AbWFYRj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:39:59 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: linux-kernel@vger.kernel.org, danial_thom@yahoo.com,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060625142440.GD8223@atjola.homenet>
References: <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Sun, 25 Jun 2006 19:44:11 +0200
Message-Id: <1151257451.7858.45.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 16:24 +0200, Björn Steinbrink wrote:

> Still no idea why your "fix" works, but the following patch also fixes
> the problem and is at least a little more like the RightThing.

Yeah.  I don't know about you, but I fully intend to blatantly ignore
that 'why' ;-)

	-Mike

