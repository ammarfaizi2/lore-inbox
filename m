Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWI1SuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWI1SuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWI1SuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:50:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22967 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030366AbWI1SuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:50:05 -0400
Date: Thu, 28 Sep 2006 11:49:39 -0700
From: Paul Jackson <pj@sgi.com>
To: menage@google.com
Cc: akpm@osdl.org, ckrm-tech@lists.sourceforge.net, mbligh@google.com,
       rohitseth@google.com, winget@google.com, dev@sw.ru, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org, jlan@sgi.com
Subject: Re: [RFC][PATCH 0/4] Generic container system
Message-Id: <20060928114939.d13c957b.pj@sgi.com>
In-Reply-To: <20060928104035.840699000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menage wrote:
> This patchset extracts the process grouping code from cpusets into a
> generic container system,

Interesting.  I'll try to give it a careful review in the next couple
of days.

I've added Jay Lan <jlan@sgi.com> to the cc list.  I encourage you to
include him on your cc list in the future - thanks.  He has expertise
in some of SGI's earlier container-like efforts.

> cpusets ... well documented
> (particularly with regards to synchronization rules).

thanks ;

Question (perhaps already answered in your code - I haven't looked
yet): can loadable kernel modules register containers?  I'd like to
see at least GPL modules be able to register containers, but I
appreciate that this could be a controversial issue.  Technically, I am
guessing that some EXPORT_GPL_SYMPOL declarations on the necessary
container registration routines would provide GPL modules with this
capability.

Guess I should read the code ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
