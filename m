Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285152AbRLMUMN>; Thu, 13 Dec 2001 15:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLMUMD>; Thu, 13 Dec 2001 15:12:03 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:2447 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S285147AbRLMUL7>; Thu, 13 Dec 2001 15:11:59 -0500
Date: Thu, 13 Dec 2001 15:07:34 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Ryan Cumming <bodnar42@phalynx.dhs.org>
cc: linux-kernel@vger.kernel.org, stewart@neuron.com,
        edward@thebsh.namesys.com
Subject: Re: passing params to boot readonly
Message-ID: <3372290000.1008274053@tiny>
In-Reply-To: <3C18FB3D.7060206@namesys.com>
In-Reply-To: <3C1841BB.8010003@neuron.com> <E16EPYW-0003nW-00@phalynx>
 <3C1874D5.5050205@namesys.com> <E16EYh6-0004At-00@phalynx>
 <3C18FB3D.7060206@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 13, 2001 10:02:21 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> Ryan Cumming wrote:
> 
>> On December 13, 2001 01:28, Hans Reiser wrote:
>> 
>>>> It'd probably be pretty easy to make a boot disk using a hacked version
>>>> of ReiserFS that refuses to replay the journal, by adding a "return 0;"
>>>> near the top of journal_read(struct super_block *) in journal.c.
>>>> However, you might feel more comfortable sending it off for data
>>>> recovery than testing kernel hacks on it ;)
>>>> 
>> 
>>> why not just edit the source code directly and recompile?

I posted a path for this a few months ago, hold on I'm rediffing real quick...

-chris

