Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269744AbUICTLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269744AbUICTLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269738AbUICTIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:08:48 -0400
Received: from mail4.utc.com ([192.249.46.193]:48383 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S269745AbUICTHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:07:48 -0400
Message-ID: <4138C0D3.5080506@cybsft.com>
Date: Fri, 03 Sep 2004 14:06:59 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
Subject: Re: lockup with voluntary preempt R0 and VP, KP, etc, disabled
References: <20040903120957.00665413@mango.fruits.de>	<20040903100946.GA22819@elte.hu>	<20040903123139.565c806b@mango.fruits.de>	<20040903103244.GB23726@elte.hu>	<20040903135919.719db41d@mango.fruits.de>	<20040903140425.26fddf8e@mango.fruits.de>	<20040903140811.37ae8067@mango.fruits.de>	<1094236105.6575.16.camel@krustophenia.net> <20040903205415.0a3cdc23@mango.fruits.de>
In-Reply-To: <20040903205415.0a3cdc23@mango.fruits.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> On Fri, 03 Sep 2004 14:28:26 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
>>Change EXTRAVERSION in the top level kernel Makefile.  The newer VP
>>patches do this for you.
> 
> 
> Ok, though my incentive was to have different versions of the same VP
> patched kernel [different config stuff though] ready w/o rebuilding in
> between.
> 
> Thanks for the tip :)
> 
> flo

I believe if you just change the EXTRAVERSION in an already built tree, 
you can then just do "make modules_install" to install them into a 
different directory.

kr
