Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUJRWKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUJRWKw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUJRWKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:10:52 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:34751 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S267454AbUJRWKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:10:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
Date: Mon, 18 Oct 2004 18:10:41 -0400
User-Agent: KMail/1.7
Cc: Matt Domsch <Matt_Domsch@dell.com>, jmorris@redhat.com,
       davem@davemloft.net, Oleg Makarenko <mole@quadra.ru>
References: <20041018192952.GB8607@lists.us.dell.com>
In-Reply-To: <20041018192952.GB8607@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181810.41406.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.58.180] at Mon, 18 Oct 2004 17:10:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 October 2004 15:29, Matt Domsch wrote:
>James, David,
>
>Oleg noted that when we call crypto_digest() on memory allocated as
> a static array in a module, rather than kmalloc(GFP_KERNEL), it
> returns incorrect data, and with other functions, a kernel panic.
>
>Thoughts as to why this may be?  Oleg's test patch appended.

Off topic Matt, but why am I getting 4 to 6 copies of the messages you 
send?  All identical time stamps, the whole works.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
