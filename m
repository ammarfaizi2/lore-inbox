Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269236AbUHZSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbUHZSbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUHZSaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:30:10 -0400
Received: from mx1.nersc.gov ([128.55.6.21]:10672 "EHLO mx1.nersc.gov")
	by vger.kernel.org with ESMTP id S269292AbUHZSZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:25:34 -0400
Message-ID: <412E2B0D.2010906@lbl.gov>
Date: Thu, 26 Aug 2004 11:25:17 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <20040826142812.GA4092@middle.of.nowhere>
In-Reply-To: <20040826142812.GA4092@middle.of.nowhere>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> From: Con Kolivas <kernel@kolivas.org>
> Date: Thu, Aug 26, 2004 at 09:07:39PM +1000
> 
>>Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
>>>
>>>- nicksched is still here.  There has been very little feedback, except 
>>>that
>>> it seems to slow some workloads on NUMA.
>>
>>The only feedback on nickshed was that it hurt NUMA 
>>somewhat, SMT interactivity was broken (an easy enough oversight)
> 
> 
> I take it that was why changing consoles between mutt and slrn would
> include a pause of several seconds on a system with a single,
> hyperthreaded cpu?
> 

More than likely.  I had found it's worse with X running (see ioperm vs. iopl thread)

> Is that fixed in 2.6.9-rc1-mm1?
> 

Good question, and how about the ioperm/iopl bit map problem?
thomas
