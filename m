Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUBAVTd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUBAVTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:19:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:20233 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265579AbUBAVRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:17:08 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch   pentium3,4
Date: Sun, 01 Feb 2004 16:18:48 -0500
Organization: TMR Associates, Inc
Message-ID: <401D6D38.3020009@tmr.com>
References: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com> <20040130131400.13190af5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1075670200 10083 192.168.12.10 (1 Feb 2004 21:16:40 GMT)
X-Complaints-To: abuse@tmr.com
Cc: James Morris <jmorris@redhat.com>, jakub@redhat.com, dparis@w3works.com,
       linux-kernel@vger.kernel.org, rspchan@starhub.net.sg
To: "David S. Miller" <davem@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040130131400.13190af5.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Fri, 30 Jan 2004 11:35:20 -0500 (EST)
> James Morris <jmorris@redhat.com> wrote:
> 
> 
>>Proposed patch below.  I think sha512 would have been ok, but might as 
>>well make them the same.
>>
>>R Chan, please test and let us know if it fixes the problem for you.
> 
> 
> I'm putting this into my tree(s), thanks James.

What didn't you like about Jakob's patch which avoids the 64 byte size 
penalty?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
