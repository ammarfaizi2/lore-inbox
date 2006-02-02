Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWBBTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWBBTdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWBBTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:33:06 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:60637 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750969AbWBBTdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:33:05 -0500
Message-ID: <43E25EB1.6010703@tmr.com>
Date: Thu, 02 Feb 2006 14:34:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <200601300822.47821.mason@suse.com> <20060121232008.GA2697@ucw.cz> <200602021717.04429.vda@ilport.com.ua>
In-Reply-To: <200602021717.04429.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> Maybe reiserfs code should use journal of reduced size on lowmem boxes.
> Basically "reiserfstune -s 1024 /dev/xxxx" on-the-fly.

I posted something about that, but you really need to cover the case 
where there are multiple mounts and the sum of all journal pins is kept 
reasonable.

See my earlier post if you care.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
