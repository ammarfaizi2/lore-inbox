Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVIVMVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVIVMVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVIVMVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:21:35 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:14283 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030279AbVIVMVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:21:35 -0400
Date: Thu, 22 Sep 2005 08:21:19 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Vadim Lobanov <vlobanov@speakeasy.net>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: A pettiness question.
In-Reply-To: <433258D1.8080301@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0509220815530.16109@localhost.localdomain>
References: <200509212046.15793.nick@linicks.net>
 <Pine.LNX.4.58.0509211305250.24543@shell4.speakeasy.net> <433258D1.8080301@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Sep 2005, Helge Hafting wrote:

> That one looks good for if-tests and such. But if you need
> a 0 or 1 for adding to a counter, then
>
> a += !!x;
>
> looks much better than
>
> a += (x != 0);
>

Actually I prefer:

a += (x == '-'-'-'?'-'-'-':'/'/'/');

  :)


-- Steve

