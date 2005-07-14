Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVGNLQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVGNLQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbVGNLQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:16:55 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:4198 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S263010AbVGNLQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:16:54 -0400
Subject: Re: Thread_Id
From: Ian Campbell <ijc@hellion.org.uk>
To: rvk@prodmail.net
Cc: Arjan van de Ven <arjan@infradead.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D6462B.8030706@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
	 <1121337567.18265.26.camel@icampbell-debian>
	 <42D6462B.8030706@prodmail.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 12:16:49 +0100
Message-Id: <1121339809.10537.6.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 16:32 +0530, RVK wrote:
> Ian Campbell wrote:
> >What Arjan is saying is that pthread_t is a cookie -- this means that
> >you cannot interpret it in any way, it is just a "thing" which you can
> >pass back to the API, that pthread_t happens to be typedef'd to unsigned
> >long int is irrelevant.
> Do you want to say for both 2.6.x and 2.4.x I should interpret that way ?

As I understand it, yes, you should never try and assign any meaning to
the values. The fact that you may have been able to find some apparent
meaning under 2.4 is just a coincidence.

Ian.

-- 
Ian Campbell
Current Noise: Nile - Annihilation Of The Wicked

BOFH excuse #127:

Sticky bits on disk.

