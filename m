Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTJWXH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJWXH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:07:27 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:30388 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261845AbTJWXHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:07:25 -0400
Message-ID: <3F985F18.4020808@cyberone.com.au>
Date: Fri, 24 Oct 2003 09:07:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: rwhron@earthlink.net, venom@sns.it, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
References: <20031021130501.GA4409@rushmore> <3F9653E6.4060209@cyberone.com.au> <20031022183028.GA10249@osdl.org> <3F973BC9.4080005@cyberone.com.au> <20031023203502.GA12778@osdl.org>
In-Reply-To: <20031023203502.GA12778@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Olien wrote:

>test5 didn't work with dbt2.  The database run kept hanging.
>I've been running reaim, which doesn't have those problems with
>older kernels, but has shown similar performance problems.
>
>I need to also check again that reaim and dbt2 still show similar
>performance issues with newer kernel versions.
>
>I've lost my test machine for today.  But I'll try test5 as-iosched
>in a test8 kernel with reaim tomorrow.  If it works well, I'll try your
>following patch.  Probably get it in the mail tomorrow afternoon.
>

Hi Dave,
Yeah thats right - I forgot. It was hanging because of as-iosched.c
too, so don't bother trying to run it :(

Anyway, Randy can reproduce regressions, so I'll work on his first.


