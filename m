Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTJONIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJONIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:08:53 -0400
Received: from dyn-ctb-210-9-246-230.webone.com.au ([210.9.246.230]:36618 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263126AbTJONIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:08:52 -0400
Message-ID: <3F8D46D7.1020105@cyberone.com.au>
Date: Wed, 15 Oct 2003 23:08:39 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk> <20031015124314.GD20846@lug-owl.de>
In-Reply-To: <20031015124314.GD20846@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan-Benedict Glaw wrote:

>On Tue, 2003-10-14 18:33:49 +0100, John Bradford <john@grabjohn.com>
>wrote in message <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>:
>
>>No, 2.6 should run on a 4MB 386 with no significant performance
>>penalty against 2.0, in my opinion.
>>
>
>Achtually, with HZ at around 100 (or oven 70..80), an old i386 or i486
>will *start* just fine, at least at 8MB. However, over some days /
>weeks, the machine gets slower and slower (my testdrive: my 90MHz
>P-Classic with 16MB). Even with that "much" RAM, I get hit by whatever
>slows down the machine. I *think* that it's the MM subsystem, but I'm
>really not skilled enough with it to blame it:)
>

Thats interesting. Its probably a memory leak I guess. Make sure to rule out
memory leaks in userspace applications, then get /proc/meminfo, 
/proc/slabinfo
on the box after it is getting slow, and also, after the box is newly 
booted.

Thanks


