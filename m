Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268292AbTBMVCn>; Thu, 13 Feb 2003 16:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268293AbTBMVCn>; Thu, 13 Feb 2003 16:02:43 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:53436 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S268292AbTBMVCl>; Thu, 13 Feb 2003 16:02:41 -0500
Date: Thu, 13 Feb 2003 16:12:28 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Patrick Mochel <mochel@osdl.org>
cc: Rusty Lynch <rusty@linux.co.intel.com>,
       Dave Jones <davej@codemonkey.org.uk>, <wingel@nano-systems.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
In-Reply-To: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Patrick Mochel wrote:
> 
[snip]
> Create a watchdog timer class. That will contain all watchdog timers, no 
> matter what bus they are on. 
> 
> I apologize for leading you astray with suggesting you treat them as 
> system devices; I was under the assumption they were more important. :)
> They should always be in the most accurate place in the tree. Don't worry 
> about what the user sees; consistency and accuracy are more important..

I like this idea, since it means my init scripts wouldn't have to dig 
around looking for watchdog directories/files on various flavours of cPCI 
CPU cards. :)

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


