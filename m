Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbULPJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbULPJPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 04:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbULPJPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 04:15:32 -0500
Received: from almesberger.net ([63.105.73.238]:51721 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262647AbULPJP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 04:15:28 -0500
Date: Thu, 16 Dec 2004 06:15:17 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalized prio_tree, revisited
Message-ID: <20041216061517.O1229@almesberger.net>
References: <20041216053118.M1229@almesberger.net> <41C14F1B.8000401@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C14F1B.8000401@kolivas.org>; from kernel@kolivas.org on Thu, Dec 16, 2004 at 08:02:19PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> While not being able to comment on the actual patch I think having a 1 
> or 0 for different types is not clear.

Yeah, it's not pretty. I also hope this division to be very
transitional, that's why I didn't bother to do anything nicer.

> Naming them different struct names would seem to me much more readable.

Struct names ? I'd rather not duplicate everything. Or did you mean
initialization function names, e.g. INIT_RAW_PRIO_TREE_ROOT ?
Or, for just the flag, maybe something like
#define PRIO_TREE_RAW		1
#define PRIO_TREE_NORMAL	0
?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
