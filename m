Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbSJJGjK>; Thu, 10 Oct 2002 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbSJJGjK>; Thu, 10 Oct 2002 02:39:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:12421 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262079AbSJJGjI>;
	Thu, 10 Oct 2002 02:39:08 -0400
Message-ID: <3DA521C1.2060707@us.ibm.com>
Date: Wed, 09 Oct 2002 23:44:17 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.41-mm2
References: <Pine.LNX.4.44.0210100841280.4384-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Wed, 9 Oct 2002, Andrew Morton wrote:
> 
>>  Ingo's original per-cpu-pages patch was said to be mainly beneficial
>>  for web-serving type things, but no specweb testing has been possible
>>  for a week or two due to oopses in the timer code.
> 
> i sent my latest timer patch to Dave Hansen but have not heard back since.
> I've attached the latest patch, this kernel also printks a bit more when
> it sees invalid timer usage.
> 
> in any case, the oops Dave was seeing i believe was fixed by Linus (the
> PgUp fix), and it was in the keyboard code. If there's anything else still
> going on then the attached patch should either fix it or provide further
> clues.

Sorry, I haven't had a chance to test it yet.  The Specweb setup likes 
to eat ethernet cards and I haven't put in replacements yet.  I'll try 
and get some time in on it tomorrow.

-- 
Dave Hansen
haveblue@us.ibm.com

