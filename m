Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUEUWxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUEUWxm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUEUWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:51:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8870 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265108AbUEUWrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:47:39 -0400
Message-ID: <40AE18A8.2000403@tmr.com>
Date: Fri, 21 May 2004 10:56:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john weber <weber@sixbit.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance Tuning
References: <20040520120514.GA29540@sixbit.org>
In-Reply-To: <20040520120514.GA29540@sixbit.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john weber wrote:
> I've been comparing kernel compile stats online to those I get 
> on my own machine, and I am baffled.
> 
> Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
> 512 MB RAM as compared to 20-30 seconds reported by folks online. 
> I am running kernel 2.6.6.
> 
> While I understand that this varies with the config, I also don't 
> see why it should vary so much.  Does anyone have any pointers on 
> how I could best troubleshoot my performance?

If you are not using "make -j3" for your build you should be able to 
pick up 20-30% improvement, assuming that you have an SMP kernel running.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
