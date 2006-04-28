Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbWD1XsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWD1XsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWD1XsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:48:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:60318 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965001AbWD1XsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:48:04 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, ashok.raj@intel.com,
       Alan Stern <stern@rowland.harvard.edu>, herbert@13thfloor.at,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com
In-Reply-To: <Pine.LNX.4.64.0604281632150.3701@g5.osdl.org>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
	 <1146075534.24650.11.camel@linuxchandra>
	 <20060426114348.51e8e978.akpm@osdl.org>
	 <20060426122926.A31482@unix-os.sc.intel.com>
	 <1146082893.24650.27.camel@linuxchandra>
	 <20060426132644.A31761@unix-os.sc.intel.com>
	 <1146265920.7063.133.camel@linuxchandra>
	 <20060428162302.79926325.akpm@osdl.org>
	 <Pine.LNX.4.64.0604281632150.3701@g5.osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 28 Apr 2006 16:48:02 -0700
Message-Id: <1146268082.7063.144.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 16:33 -0700, Linus Torvalds wrote:
> 
> On Fri, 28 Apr 2006, Andrew Morton wrote:
> > 
> > hm.  I'm leaning more towards doing something expedient and obvious for
> > 2.6.17.  It's pretty late in the cycle, and the only downside is the loss
> > of a kbyte or two.  Plus I'll be at linuxtag next week and won't be around to
> > help out.
> > 
> > So if it's OK, can we do something minimal, revisit it after 2.6.17?
> 
> I'm personally fine with the current state: it should be stable and work.

in that case _no_ change would be the best option.

> If there are any remaining _bugs_ that people know about, please send 
> fixes to me, but I think we can definitely leave the "free the unnecessary

No bugs that i know of.
 
> memory" stuff to after 2.6.17.

sounds good.
> 
> 		Linus
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


