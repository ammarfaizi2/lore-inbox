Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUIHTGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUIHTGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUIHTGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:06:33 -0400
Received: from mail.tmr.com ([216.238.38.203]:16653 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269310AbUIHTGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:06:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Major XFS problems...
Date: Wed, 08 Sep 2004 15:06:32 -0400
Organization: TMR Associates, Inc
Message-ID: <chnkqd$u7n$1@gatekeeper.tmr.com>
References: <20040908154434.GE390@unthought.net><20040908123524.GZ390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1094669966 30967 192.168.12.100 (8 Sep 2004 18:59:26 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1094661418.19981.36.camel@hole.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks wrote:
> On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> 
>>SMP systems on 2.6 have a problem with XFS+NFS.
> 
> 
> Knfsd threads in 2.6 are no longer serialised by the BKL, and the
> change has exposed a number of SMP issues in the dcache.  Try the
> two patches at
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2
> 
> and
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@1.1722.48.23
> 
> (the latter is in recent Linus kernels).  If you're still having
> problems after applying those patches, Nathan and I need to know.

Do I read you right that this is an SMP issue and that the NFS, quota, 
backup and all that are not relevant? I will pass on the patches you 
supplied to someone who is having similar problems with no NFS and no 
quota, a TB of storage which gets beaten without mercy 24x4.5 and which 
has been having issues as load has gone up.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
