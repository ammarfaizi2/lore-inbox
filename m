Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUJAQcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUJAQcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJAQcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:32:16 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34437 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264443AbUJAQcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:32:10 -0400
Message-ID: <415D8661.3000406@nortelnetworks.com>
Date: Fri, 01 Oct 2004 10:31:29 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] inotify: make user visible types portable
References: <1096410792.4365.3.camel@vertex>	<1096583108.4203.86.camel@betsy.boston.ximian.com>	<20040930155704.16d71cec.pj@sgi.com>	<1096608925.4803.2.camel@localhost>	<20040930234436.097e6dfe.pj@sgi.com>	<1096616399.4803.26.camel@localhost>	<20041001084009.6b33c1a1.pj@sgi.com>	<1096645624.7676.18.camel@betsy.boston.ximian.com> <20041001091325.7fbc6971.pj@sgi.com>
In-Reply-To: <20041001091325.7fbc6971.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Robert wrote:
> 
>>The structure needs to be used exactly the same between the kernel and
>>the user.  We both agree to that, right?  It is user visible.
> 
> 
> Certainly the ABI, yes.  These stubborn beasts called computers that we
> labour over just won't work otherwise.
> 
> I'd have no objections to the user header spelling "__u32" where the
> kernel header spelled "u32".

I believe there is a long-term goal to separate out the userspace-visible part 
of the kernel headers into a separate header area, and include them into the kernel.

Even without that, the headers are periodically extracted and cleaned up.  Why 
make that job harder than it needs to be?

Chris

