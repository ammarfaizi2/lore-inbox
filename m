Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVDHRLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVDHRLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVDHRLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:11:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21489 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261824AbVDHRL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:11:29 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       inaky.perez-gonzalez@intel.com, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <20050408062811.GA19204@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com>
	 <20050408062811.GA19204@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1112980281.22429.9.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Apr 2005 10:11:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2005-04-07 at 23:28, Ingo Molnar wrote:

> this one looks really clean.
> 
> it makes me wonder, what is the current status of fusyn's? Such a light 
> datastructure would be much more mergeable upstream than the former 
> 100-queues approach.


	Inaky was telling me that 100 queues approach is two years old. 

The biggest problem is that fusyn has it's own PI system .. So it's not
clear if that will work with the RT mutex,. I was thinking the PI stuff
could be made generic so, fusyn, maybe futex, can use it also .

Daniel

