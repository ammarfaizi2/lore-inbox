Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUBVCwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUBVCwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:52:14 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:54670 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261655AbUBVCv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:51:56 -0500
Message-ID: <40381819.7000606@cyberone.com.au>
Date: Sun, 22 Feb 2004 13:46:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Mike Fedyk <mfedyk@matchmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <403814E5.3070106@cyberone.com.au>
In-Reply-To: <403814E5.3070106@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> I have an idea it might be worthwhile to try using inactive list
> scanning as an input to slab pressure...
>

Err that is what it does, of course. My idea was the other way
round - use active list scanning as input. So no, that probably
won't help.

Only one way to find out though. Patch against 2.6.3-mm2.

