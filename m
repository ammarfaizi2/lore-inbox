Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbVH2VEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVH2VEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVH2VEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:04:00 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38559 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S1751004AbVH2VEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:04:00 -0400
Date: Mon, 29 Aug 2005 23:02:26 +0200 (CEST)
From: =?ISO-8859-15?Q?Peter_M=FCnster?= <pmlists@free.fr>
X-X-Sender: peter@gaston.free.fr
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel freezes with 2.6.12.5 and 2.6.13
In-Reply-To: <20050829191754.GW7991@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0508292253590.32579@gaston.free.fr>
References: <Pine.LNX.4.58.0508292050180.28621@gaston.free.fr>
 <20050829191754.GW7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Chris Wright wrote:

> * Peter Münster (pmlists@free.fr) wrote:
> > with 2.6.12.4 no problem. But with a newer version, I get a black screen
> > and no more network access, when trying to print (lpr some-file.ps).
> > Everything else seems to work ok.
> > Printer is a network-printer managed by cups.
> > I suppose, it's a smp-problem, so here is my /proc/cpuinfo:
> 
> Is this 100% reproducible?  Do you get any kernel oops messages on
> the console?  There are very few patches between 2.6.12.4 and 2.6.12.5,
> so if the problem is reproducible can you narrow to the specific patch?

Yes, it's 100% reproducible. But I do not get any message. Display is
shutting down, and no more access with ssh. Ctrl-Alt-Del does not work
neither. Nothing in /var/log/messages.
Of course, I can try to narrow down to the specific patch, if you send me
the different patches. I only have the diff between 2.6.12.4 and 2.6.12.5
and I don't know how to extract the patches.
Cheers, Peter

-- 
http://pmrb.free.fr/contact/
