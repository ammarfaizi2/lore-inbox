Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUEKSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUEKSfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEKSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:35:23 -0400
Received: from mail.tmr.com ([216.238.38.203]:56837 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263134AbUEKSfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:35:15 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
Date: Tue, 11 May 2004 14:37:13 -0400
Organization: TMR Associates, Inc
Message-ID: <c7r676$gvo$1@gatekeeper.tmr.com>
References: <1084157289.7867.0.camel@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084300326 17400 192.168.12.100 (11 May 2004 18:32:06 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1084157289.7867.0.camel@latitude>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Oberheide wrote:
> Greetings,
> 
> This feature has been brought up several times before, as can be seen
> here:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/0798.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0598.html
> http://www.uwsg.iu.edu/hypermail/linux/kernel/9803.0/0223.html
> 
> For those unfamiliar, a file linux/.patches would be adding to the
> source tree.  When applying patches to the source tree, descriptive
> information would be written to .patches.  After compilation and running
> of this kernel, the .patches information would be accessible through
> /proc/patches.gz; similar to the /proc/config.gz feature.

The first question would be, patches between the current kernel and 
what? Vendor kernel, people may not have it. Kernel.org kernal, just the 
patches to a current vendor kernel diff would be pretty huge in some cases.

Let's say it looks like a high cost/benefit ratio, would be much less 
effective unless it were used for every patch, and feels like something 
you might want to do within an organization rather than as a general 
practice.

Sorry, you asked for comments...


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
