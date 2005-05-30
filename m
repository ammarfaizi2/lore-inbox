Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVE3TeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVE3TeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVE3TeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:34:09 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:55958 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261714AbVE3TeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:34:01 -0400
Date: Mon, 30 May 2005 21:33:13 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Karim Yaghmour <karim@opersys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <429B61F7.70608@opersys.com>
Message-Id: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Karim Yaghmour wrote:

> 
> Esben Nielsen wrote:
> > Ofcourse, there is a lot of buts to that. You have to check that the
> > driver doesn't take a call path which is nontermnistic in special cases
> > and the path between your application and the driver is deterministic.
> > A static code checker would be nice...
> 
> Which gets up back where we began: drivers that are non-deterministic
> will continue being deterministic regardless of what solution is adopted,
> if any, and will be in need of a re-write/major-modification, which
> itself will have little or no added value for non-rters ...

But if you do have to maintain your own driver it is a lot easier to start
from an existing and fix that one than it is to start all over. I bet the
modifcations aren't too big for many drivers anyways. When I get more time
I'll try to look into some drivers. Many of them is propably just about
removing printk's and the like.

Esben

> 
> Karim

