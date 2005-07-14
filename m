Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVGNKjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVGNKjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVGNKjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:39:43 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:51189 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261615AbVGNKjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:39:37 -0400
Subject: Re: Thread_Id
From: Ian Campbell <ijc@hellion.org.uk>
To: rvk@prodmail.net
Cc: Arjan van de Ven <arjan@infradead.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D63916.7000007@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 11:39:27 +0100
Message-Id: <1121337567.18265.26.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 15:36 +0530, RVK wrote:

> bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;

That's an implementation detail which you cannot determine any
information from.

What Arjan is saying is that pthread_t is a cookie -- this means that
you cannot interpret it in any way, it is just a "thing" which you can
pass back to the API, that pthread_t happens to be typedef'd to unsigned
long int is irrelevant.  

Ian.

-- 
Ian Campbell
Current Noise: Nile - Annihilation Of The Wicked

Don't tell me what you dreamed last night for I've been reading Freud.

