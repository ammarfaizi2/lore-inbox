Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVCIUyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVCIUyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVCIUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:42:34 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18571 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262070AbVCIU1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:27:38 -0500
Message-ID: <422F5D78.7030901@tmr.com>
Date: Wed, 09 Mar 2005 15:32:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com>
In-Reply-To: <20050309083923.GA20461@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> And to further test this whole -stable system, I've released 2.6.11.2.
> It contains one patch, which is already in the -bk tree, and came from
> the security team (hence the lack of the longer review cycle).
> 
> It's available now in the normal kernel.org places:
> 	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
> which is a patch against the 2.6.11.1 release.  If consensus arrives
> that this patch should be against the 2.6.11 tree, it will be done that
> way in the future.

I think you need both x.y.z=>x.y.z.N and x.y.z.N-1=>x.y.z.N patches. My 
systems which are following the -stable will just need the most recent, 
but doing x.y.z-1=>x.y.z.N gets really ugly for higher values of N.

It can be automated, it's just two (presumably tiny) patchsets per release.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
