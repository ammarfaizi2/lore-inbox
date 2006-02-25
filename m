Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWBYDIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWBYDIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWBYDIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:08:37 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:52872 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932598AbWBYDIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:08:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SQ2tqWBDo6qemeyrhQOfuLGW+0+JWoMx3oel8ExMJXhpQxJRe1+1Sv66lRi6y0KVg3kuGrO3wFh1KJV3ZNeRIXz/jCyjjpodzjIYm92nGpkHy3mMki/fPJzWctDu6MIr7LHaZxTNdl0jZK+mw6Rn7U69uXXzBrSQ2mhFeKkl8q4=  ;
Message-ID: <43FFCA30.9040008@yahoo.com.au>
Date: Sat, 25 Feb 2006 14:08:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       MIke Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
References: <1140183903.14128.77.camel@homer> <43FFAFE9.8000206@bigpond.net.au> <43FFC411.8010106@yahoo.com.au> <200602251357.24665.kernel@kolivas.org>
In-Reply-To: <200602251357.24665.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 25 February 2006 13:42, Nick Piggin wrote:

>>I tried this angle years ago and it didn't work :)
> 
> 
> Our "2.6 forever" policy is why we're stuck with this approach. We tried 
> alternative implementations in -mm for a while but like all alternatives they 
> need truckloads more testing to see if they provide a real advantage and 
> don't cause any regressions. This made it impossible to seriously consider 
> any alternatives.
> 
> I hacked on and pushed plugsched in an attempt to make it possible to work on 
> an alternative implementation that would make the transition possible in a 
> stable series. This was vetoed by Linus and Ingo and yourself for the reason 
> it dilutes developer effort on the current scheduler. Which leaves us with 
> only continually polishing what is already in place.
> 

Yes. Hence my one-liner.

I still don't think plugsched is that good of an idea for mainline.
Not too many people seem to be unhappy with the scheduler we have,
so just because this little problem comes up I don't think that
means it's time to give up and merge plugsched and 10 other policies.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
