Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbRFQVo0>; Sun, 17 Jun 2001 17:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbRFQVoF>; Sun, 17 Jun 2001 17:44:05 -0400
Received: from mail007.syd.optusnet.com.au ([203.2.75.231]:12252 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S263002AbRFQVn4> convert rfc822-to-8bit; Sun, 17 Jun 2001 17:43:56 -0400
From: alterity <alterity@dingoblue.net.au>
To: =?ISO-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 VM & swap question
Date: Mon, 18 Jun 2001 07:43:19 +1000
Organization: alterity inc.
Reply-To: alterity@dingoblue.net.au
Message-ID: <fr8qitgqmqsnt9u38bj7di2dtj5vpbr8sc@4ax.com>
In-Reply-To: <20010617104836.B11642@opus.bloom.county> <20010617205835.A12767@unthought.net>
In-Reply-To: <20010617205835.A12767@unthought.net>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001 20:58:35 +0200, you wrote:

>I have a database server with 1G phys and 1G swap. It uses 950+ MB for cache,
>as it should, and doesn't even *touch* swap.  This is 2.4.5.

I thought the new rule is: 
	total_memory = max(physical, swap);

And the old rule was:
	total_memory = physical + swap;

Hence under a 1G physical and 1G swap setup, the kernel would never
access swap. 

Is this the case, or am I a couple of megabytes short in my
understanding of things?




Al

