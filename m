Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWACNV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWACNV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWACNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:21:59 -0500
Received: from smtp105.plus.mail.mud.yahoo.com ([68.142.206.238]:38768 "HELO
	smtp105.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932278AbWACNV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:21:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ACicSMEqUIchs3IpiL96NvW8wfvoO4veUWCIDVahdqSz0oeFnNJes4sTAj05luc3sLLeNC6HusH6aBq6nLkupOAQdcAuxRl4B26qBh8QI/r2Z+Ls/ImZzVI8nHit4+G4Okj/MM7t1lSLqvtmAPeNrZwJ0tM/fdzV+tUhnn+LxuM=  ;
Message-ID: <43BA7A73.6070407@yahoo.com.au>
Date: Wed, 04 Jan 2006 00:21:55 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com> <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au> <20051231202602.GC3903@dmt.cnet> <20060102214016.GA13905@dmt.cnet> <1136265106.5261.34.camel@npiggin-nld.site> <20060103101106.GA3435@dmt.cnet>
In-Reply-To: <20060103101106.GA3435@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Tue, Jan 03, 2006 at 04:11:46PM +1100, Nick Piggin wrote:
> 

>>I guess I was hoping to try to keep it simple, and just have two
>>variants, the __ version would require the caller to do the locking.
> 
> 
> I see - one point is that the two/three underscore versions make
> it clear that preempt is required, though, but it might be a bit
> over-complicated as you say.
> 
> Well, its up to you - please rearrange the patch as you wish and merge
> up?
> 

OK I will push it upstream - thanks!

We can revisit details again when some smoke clears from the
coming 2.6.16 merge cycle?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
