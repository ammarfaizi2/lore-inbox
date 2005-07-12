Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVGLOkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVGLOkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGLOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:38:14 -0400
Received: from mail.ccur.com ([208.248.32.212]:23943 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261466AbVGLOhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:37:12 -0400
Subject: Re: Merging relayfs?
From: Steve Rotolo <steve.rotolo@ccur.com>
To: Greg KH <greg@kroah.com>
Cc: Karim Yaghmour <karim@opersys.com>, Tom Zanussi <zanussi@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
In-Reply-To: <20050712052333.GA11614@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <20050712030555.GA1487@kroah.com> <42D3331F.8020705@opersys.com>
	 <20050712032424.GA1742@kroah.com> <42D33E99.7030101@opersys.com>
	 <20050712043056.GC2363@kroah.com> <42D349C9.3060805@opersys.com>
	 <20050712052333.GA11614@kroah.com>
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1121179018.1438.14.camel@whiz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 12 Jul 2005 10:36:58 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jul 2005 14:37:12.0439 (UTC) FILETIME=[30D35870:01C586EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 01:23, Greg KH wrote:
> And you _are_ doing kernel debugging and tracing with ltt, what's wrong
> with admitting that?
> 

Hi.  I think that viewing tracing tools like LTT and systemtap as
strictly kernel debug tools is very short-sighted.  With a good
post-processing tool, tracing is very useful to application developers
who can benefit by visualizing the interaction between user-level tasks
and the OS as well as the synchronization of multiple tasks/threads.

IOW, tracing is in many ways an _application_ debug tool, not a _kernel_
debug tool.  And application developers usually do not want to run a
debug kernel.

I would like to see relayfs merged.

-- 
Steve Rotolo
<steve.rotolo@ccur.com>

