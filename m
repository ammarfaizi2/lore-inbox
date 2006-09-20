Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWITXaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWITXaA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWITX37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:29:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3732 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750705AbWITX37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:29:59 -0400
Date: Wed, 20 Sep 2006 16:29:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: clameter@sgi.com, rohitseth@google.com, ckrm-tech@lists.sourceforge.net,
       devel@openvz.org, npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920162945.7f442923.pj@sgi.com>
In-Reply-To: <1158774491.7705.32.camel@localhost.localdomain>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773699.7705.19.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609201012310.30793@schroedinger.engr.sgi.com>
	<1158774491.7705.32.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan replying to Christoph:
> > Cpusets can share nodes. I am not sure what the problem would be? Paul may 
> > be able to give you more details.
> 
> If it can do it in a human understandable way, configured at runtime
> with dynamic sharing, overcommit and reconfiguration of sizes then
> great. Lets see what Paul has to say.

Unless I'm missing something (a frequent occurrence) such a use of
cpusets looses on the understandable, is hobbled on the overcommit, and
has to make do with a somewhat oddly limited and not trivial to
configure approximation of the dynamic sharing.  And the
reconfiguration would seem to be a great exercise of memory hotunplug
(echos of the original motivation for fake numa - exercising cpusets ;).

Not exactly passing with flying colors ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
