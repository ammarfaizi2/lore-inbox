Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWEaT2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWEaT2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWEaT2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:28:22 -0400
Received: from mail.tmr.com ([64.65.253.246]:21178 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S965120AbWEaT2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:28:21 -0400
Message-ID: <447DEEB7.2060707@tmr.com>
Date: Wed, 31 May 2006 15:29:59 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org> <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506180551.GB22474@thunk.org> <6935C0D2-528C-47B5-A7A8-7FCA2672FCD7@neostrada.pl> <20060525000829.GA24897@thunk.org>
In-Reply-To: <20060525000829.GA24897@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Thu, May 25, 2006 at 12:47:18AM +0200, Marcin Dalecki wrote:
>> Anytime you start to make unquantified assumptions in the context of
>> / dev/random the issue turns up that this whole thing is not worth
>> the trouble because much simpler approaches will be sufficient
>> enough to acomplish what it does. On the other hand you can't
>> provide any actual full analysis of it's behaviour - which is just
>> *not acceptable* for anybody trully concerned. And this in
>> conjunction makes the WHOLE idea behind it questionable.
> 
> Nobody can provide any kind of full analysis about whether or not
> SHA-2 or AES is secure, either.  Does that we mean we just give up and
> go home?  No, we do the best job we can, with the best information we
> have.  Sometimes that means we have to make assumptions, but the
> entire construction of AES and SHA-2 is based on similar assumptions,
> too.
> 
> Academics who make "full analysis" generally use as axioms things like
> "assume MD5 is secure" or "assume SHA-1 is secure", which are really
> fancy assumptions.  If we had used a "simpler approaches" based such
> axioms we might have been in trouble.  So I think some of the analysis
> and designs choices that I made in /dev/random is most definitely
> worth the trouble.
> 
> Regards,
> 
> 						- Ted
As usual I agree with you, for lack of a really good random source it's 
worth doing the best possible job with what's available. Would be nice 
to have a cheap USB bit babbler, tho.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

