Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJWCXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 22:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJWCXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 22:23:55 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:36770 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261563AbTJWCXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 22:23:54 -0400
Message-ID: <3F973BC9.4080005@cyberone.com.au>
Date: Thu, 23 Oct 2003 12:24:09 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au> <20031022183028.GA10249@osdl.org>
In-Reply-To: <20031022183028.GA10249@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Olien wrote:

>Sorry, this patch didn't fix our performance problems.  Mary just
>finished running dbt2 on test8 with your patch:
>
>NOTPM   kernel          scheduler
>965     2.6.0-test8-np  AS
>1632    2.6.-test6-mm4  deadline
>

Thanks. hmm.
And NOTPM was better with AS in test5? Does using as-iosched.c from test5
in a test8 kernel help?


