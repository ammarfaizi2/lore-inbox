Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUEXXVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUEXXVh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUEXXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:21:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:62431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263875AbUEXXVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:21:16 -0400
Date: Mon, 24 May 2004 16:21:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040524162115.O22989@build.pdx.osdl.net>
References: <67B3A7DA6591BE439001F2736233351202B47E76@xch-nw-28.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E76@xch-nw-28.nw.nos.boeing.com>; from Joseph.V.Laughlin@boeing.com on Mon, May 24, 2004 at 04:04:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Laughlin, Joseph V (Joseph.V.Laughlin@boeing.com) wrote:
> Currently, we're using sched_setaffinity() to control it, which existed
> in our 2.4.19 kernel.  (but, you have to be root to use it, and we'd
> like non-root users to be able to change the affinity.)

Sounds like it's patched in.  And it likely doesn't require root per se,
but CAP_SYS_NICE (as the 2.6 code does).

So, you've got choices of how to disable those capability checks to do
what you want.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
