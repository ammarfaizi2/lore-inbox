Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTDOO1Z (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTDOO1Y 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:27:24 -0400
Received: from franka.aracnet.com ([216.99.193.44]:57272 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261539AbTDOO1X 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:27:23 -0400
Date: Tue, 15 Apr 2003 07:39:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@codemonkey.org.uk>, Duncan Sands <baldrick@wanadoo.fr>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <70400000.1050417541@[10.10.2.4]>
In-Reply-To: <20030415120457.GA11998@suse.de>
References: <80690000.1050351598@flay>
 <200304142310.05110.baldrick@wanadoo.fr> <20030414211740.GB11160@suse.de>
 <200304151357.32819.baldrick@wanadoo.fr> <20030415120457.GA11998@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > It is questionable.  Since even in core kernel code there are
>  > many places with
>  > 	if (cond)
>  > 		BUG();
>  > rather than
>  > 	BUG_ON(cond);
>  > it may be worth seeing if converting them makes a difference
>  > (increases code size though).
> 
> The spinlock code sticks out as a possible good target.
> Any takers for benchmarking ?

I can try that ... However, do I have to use gcc > 3 to see anything?
I had some vague recollection that unlikely() doesn't do much for gcc 2.95,
is that correct?

M.


