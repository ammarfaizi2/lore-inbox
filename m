Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTIBV5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTIBV5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:57:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22025
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263893AbTIBV5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:57:36 -0400
Subject: Re: Driver Model
From: Robert Love <rml@tech9.net>
To: jimwclark@ntlworld.com
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
In-Reply-To: <200309022244.55500.jimwclark@ntlworld.com>
References: <Pine.LNX.4.44.0309021420570.5614-100000@cherise>
	 <200309022244.55500.jimwclark@ntlworld.com>
Content-Type: text/plain
Message-Id: <1062540483.29020.31.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Tue, 02 Sep 2003 18:08:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 17:44, James Clark wrote:

> Would a more rigid 'plugin' interface and the concequent move from mainly 
> 'source' modules to binary 'plugins' (still with source-code available for 
> all to see) mean that (a) Kernel was smaller (2) Had to be 
> released/recompiled less (4) Was EVEN more stable and (4) 'plugins' were more 
> portable across releases and easier to install ?

I do not think any of these implications are true, except (4).

A stable driver API would certainly imply (4).  But I see no relation to
(a) -- actually, an API would bring complications and thus bloat, if
anything.  I see no relation to (2).  And (3) just seems like a wild
guess.

I agree that (4) would be a good thing.  The problem is, its really not
what we have here today and not what any of the kernel developers want. 
95% of the drivers (and 100% of those that the kernel developers use)
_are_ source-based and in the tree, so why have a stable API for them?

In other words, yes, (4) is nice.  But not that nice, as a stable API
and driver interface implies a lot of other things that are not
necessarily good.

On the bright side, I do think that we will see a much more stable API
in 2.6.  2.4.n for n after Marcelo took over has also been stable.

	Robert Love


