Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbTC3QaC>; Sun, 30 Mar 2003 11:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbTC3QaC>; Sun, 30 Mar 2003 11:30:02 -0500
Received: from main.gmane.org ([80.91.224.249]:18058 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261488AbTC3QaB>;
	Sun, 30 Mar 2003 11:30:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: Update direct-rendering to current DRI CVS tree.
Date: Sun, 30 Mar 2003 09:14:58 -0500
Message-ID: <3E86FBE2.8080804@myrealbox.com>
References: <200303300712.h2U7CVB32581@hera.kernel.org> <20030330114544.GB16060@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Cc: dri-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  >  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,2)
>  >  #define down_write down
>  >  #define up_write up
> 
> #if can go, like it did in other parts of the patch.

What will replace it?  If you intend to keep the two 
projects in sync and easy to update, I'm afraid that it will 
call for putting all the later (>=2.4.16) #if's back, as 
well as adding gaurds for the current 2.5-specific 
scheduling/worqueue changes.  Unless, of course, the dri 
maintainers are willing to make TRUNK incompatible with 
linux-2.4...

Cheers,
Nicholas


