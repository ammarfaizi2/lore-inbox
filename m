Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWGORdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWGORdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWGORdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 13:33:19 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52858 "EHLO
	asav06.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750727AbWGORdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 13:33:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAKTBuESBUA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: functions returning 0 on success [was: [PATCH] Fix a memory leak in the i386 setup code]
Date: Sat, 15 Jul 2006 13:33:16 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060710221308.5351.78741.stgit@localhost.localdomain> <44B2D893.9050209@tls.msk.ru>
In-Reply-To: <44B2D893.9050209@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607151333.16817.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 18:45, Michael Tokarev wrote:
> In such cases when a routine returns 0 on error, I usually write
> it this way:
> 
> š šif (request_resource() != 0)
> š š šfail()
> 


Many write:

	error = do_something();
	if (error) {
		...
	}

And then it really obvious.

-- 
Dmitry
