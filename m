Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275751AbTHOIKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275752AbTHOIKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:10:11 -0400
Received: from dyn-ctb-203-221-74-26.webone.com.au ([203.221.74.26]:24583 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275750AbTHOIKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:10:06 -0400
Message-ID: <3F3C9523.7090903@cyberone.com.au>
Date: Fri, 15 Aug 2003 18:09:07 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andries Brouwer <aebr@win.tue.nl>, val@nmt.edu, daw@mozart.cs.berkeley.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
References: <20030809173329.GU31810@waste.org>	<20030813032038.GA1244@think>	<20030813040614.GP31810@waste.org>	<20030814165320.GA2839@speare5-1-14>	<bhgoj9$9ab$1@abraham.cs.berkeley.edu>	<20030815001713.GD5333@speare5-1-14>	<20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com>
In-Reply-To: <20030815004004.52f94f9a.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David S. Miller wrote:

>On Fri, 15 Aug 2003 09:30:03 +0200
>Andries Brouwer <aebr@win.tue.nl> wrote:
>
>
>>On Thu, Aug 14, 2003 at 06:17:13PM -0600, Val Henson wrote:
>>
>>
>>>entropy(x) >= entropy(x xor y)
>>>entropy(y) >= entropy(x xor y)
>>>
>>Is this trolling? Are you serious?
>>
>
>These lemma are absolutely true.  XOR is the worst way
>to gain entropy because it means that if you are able
>to know anything about either 'x' or 'y' then you are
>able to know something about the resulting entropy.
>

_Either_ x or y? Surely not! 1 ^ ? = ? you still have 1
bit of entropy.

