Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUBEPkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 10:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUBEPkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 10:40:31 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:36834 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265311AbUBEPk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 10:40:27 -0500
Message-ID: <402263E7.6010903@cyberone.com.au>
Date: Fri, 06 Feb 2004 02:40:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mattias Wadenstein <maswan@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
In-Reply-To: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mattias Wadenstein wrote:

>Greetings.
>
>While testing a file server to store a couple of TB in resonably large
>files (>1G), I noticed an odd performance behaviour with the md raid0 in a
>pristine 2.6.2 kernel as compared to a 2.4.24 kernel.
>
>When striping two md raid5:s, instead of going from about 160-200MB/s for
>a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
>135M/s in single stream read performance.
>
>

Can you try booting with elevator=deadline please?

