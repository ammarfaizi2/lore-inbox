Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWD1Xfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWD1Xfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWD1Xfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:35:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751400AbWD1Xfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:35:46 -0400
Date: Fri, 28 Apr 2006 16:33:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, ashok.raj@intel.com, stern@rowland.harvard.edu,
       herbert@13thfloor.at, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
In-Reply-To: <20060428162302.79926325.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604281632150.3701@g5.osdl.org>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
 <1146075534.24650.11.camel@linuxchandra> <20060426114348.51e8e978.akpm@osdl.org>
 <20060426122926.A31482@unix-os.sc.intel.com> <1146082893.24650.27.camel@linuxchandra>
 <20060426132644.A31761@unix-os.sc.intel.com> <1146265920.7063.133.camel@linuxchandra>
 <20060428162302.79926325.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Apr 2006, Andrew Morton wrote:
> 
> hm.  I'm leaning more towards doing something expedient and obvious for
> 2.6.17.  It's pretty late in the cycle, and the only downside is the loss
> of a kbyte or two.  Plus I'll be at linuxtag next week and won't be around to
> help out.
> 
> So if it's OK, can we do something minimal, revisit it after 2.6.17?

I'm personally fine with the current state: it should be stable and work. 
If there are any remaining _bugs_ that people know about, please send 
fixes to me, but I think we can definitely leave the "free the unnecessary 
memory" stuff to after 2.6.17.

		Linus
