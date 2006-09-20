Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWITRTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWITRTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWITRTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:19:53 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:46991 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932075AbWITRTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=O5+070c4nY5MDwkX2PrA0tr/m7v08BkVLjw8PAat1p/sOSCbsgIcNFrLk7OLgt+dTfR0xtxTzDmjoQnrRRnvJadcHDf7MyZPZuIDqCXK3aDjx+2uwTsZMuRl8UoCILGhFUNLWMjjn1nDQKe6St73DIcJ11sif+WUOi/Nl82GmB4=  ;
Message-ID: <45117830.3080909@yahoo.com.au>
Date: Thu, 21 Sep 2006 03:19:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: rohitseth@google.com, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <4510D3F4.1040009@yahoo.com.au> <Pine.LNX.4.64.0609200925280.30572@schroedinger.engr.sgi.com> <451172AB.2070103@yahoo.com.au> <Pine.LNX.4.64.0609201006420.30793@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609201006420.30793@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 21 Sep 2006, Nick Piggin wrote:
> 
> 
>>If it wasn't clear was talking specifically about the hooks for page
>>tracking rather than the whole patchset. If anybody wants such page
>>tracking infrastructure in the kernel, then this (as opposed to the
>>huge beancounters stuff) is what it should look like.
> 
> 
> Could you point to the patch and a description for what is meant here by 
> page tracking (did not see that in the patch, maybe I could not find it)? 
> If these are just statistics then we likely already have 
> them.
> 

Patch 2/5 in this series provides hooks, and they are pretty unintrusive.

  mm/filemap.c              |    4 ++++
  mm/page_alloc.c           |    3 +++
  mm/rmap.c                 |    8 +++++++-
  mm/swap.c                 |    1 +
  mm/vmscan.c               |    1 +

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
