Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVFGTKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVFGTKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVFGTKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:10:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16266 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261962AbVFGTKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:10:36 -0400
Date: Tue, 7 Jun 2005 14:10:01 -0500
From: Dean Nelson <dcn@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, linux-ia64@vger.kernel.org, linux-altix@sgi.com,
       edwardsg@sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       anton.wilson@camotion.com
Subject: Re: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
Message-ID: <20050607191001.GA8768@sgi.com>
References: <1118112390.4533.10.camel@localhost.localdomain> <20050607053306.GA16181@elte.hu> <1118143504.4533.21.camel@localhost.localdomain> <20050607154846.GA1253@sgi.com> <1118165519.5667.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118165519.5667.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:31:59PM -0400, Steven Rostedt wrote:
> On Tue, 2005-06-07 at 10:48 -0500, Dean Nelson wrote:
> > You are correct xpc_activating() needs to be changed to use MAX_RT_PRIO.
> > So please do add that change to your patch.
> 
> I haven't tested this patch, I just used the previous patch (which I did
> test) and added your change.

I just built and tested a kernel and xp/xpc/xpnet modules with your patch
applied. It ran fine. The priorities of the xpc kthreads were correct.

Looks good to me.

Thanks,
Dean

