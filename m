Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUBWBnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbUBWBnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:43:47 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:63967 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261776AbUBWBnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:43:45 -0500
Message-ID: <40395ACE.4030203@cyberone.com.au>
Date: Mon, 23 Feb 2004 12:43:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/
>
>

URL is of course,
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm3/

This still doesn't shrink slab correctly on highmem machines
because you dropped my patch :(

A better way, IMO, is use mine instead of shrink_slab-for-all-zones.patch

Your other VM patches look good though.

