Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWBOKcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWBOKcL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBOKcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:32:11 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:28247 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751104AbWBOKcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:32:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6h/JzHaq76qG/RsVoAITDjQPY1oKbx7/MuphA1WniavRe71QHlsTlOy6BCqMKTq9Sl9HFxQSE06YiCnunYLf21Z7j/xy6rCQsUxZxaVGE1f44Vnf/FXUs0OF8Ac9auBMsUp9uYFoHnVeuXZS4I1DSTtwoEi3t9G/XVUtng1FXdc=  ;
Message-ID: <43F2E7C8.9040600@yahoo.com.au>
Date: Wed, 15 Feb 2006 19:35:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zijlstra <peter@programming.kicks-ass.net>
CC: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, christoph@lameter.com
Subject: Re: + vmscan-rename-functions.patch added to -mm tree
References: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net>	 <2cd57c900602141847m7af4ec7ap@mail.gmail.com>	 <43F29B84.6020009@yahoo.com.au> <1139985978.6722.14.camel@localhost.localdomain>
In-Reply-To: <1139985978.6722.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Wed, 2006-02-15 at 14:09 +1100, Nick Piggin wrote:

>>shrink_zone and do_shrink_zone don't really say any more to me than
>>shrink_zone and shrink_cache.
> 
> 
> I know not everybody believes in a plugable reclaim policy, but that is
> what I'm building. And from that POV I'd rather not see the
> active/inactive names get used here.
> 

active/inactive is what we have now. If you manage to get a pluggable
reclaim policy merged then I assure you, renaming these yet again will
be the least of your worries :)

> My vote goes to Coywolf's suggestion.
> 

What was that?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
