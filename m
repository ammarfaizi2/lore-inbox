Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTKTWcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTKTWcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:32:17 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:22187 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263007AbTKTWcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:32:14 -0500
Message-ID: <3FBD40BB.6080100@nortelnetworks.com>
Date: Thu, 20 Nov 2003 17:31:23 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: high res timestamps and SMP
References: <3FBBF148.20203@nortelnetworks.com> <1069297341.23568.130.camel@cog.beaverton.ibm.com> <16316.38292.729957.491201@alkaid.it.uu.se> <20031120194644.GA11889@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

> Running the multiplier at a set fraction of the processor speed
> is a good idea I think. Go look at any large x86 box (and possibly ia64
> box) and you will find the timebases are not synced.

By "large", you mean NUMA, right?  I was under the impression that the 
kernel did sync up the timebases for SMP.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

