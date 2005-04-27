Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVD0SOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVD0SOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVD0SOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:14:15 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:429 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261914AbVD0SN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:13:26 -0400
Date: Wed, 27 Apr 2005 11:12:45 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: David Teigland <teigland@redhat.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050427181245.GB938@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050426053930.GA12096@redhat.com> <20050426184845.GA938@ca-server1.us.oracle.com> <20050427132343.GX4431@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427132343.GX4431@marowsky-bree.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 03:23:43PM +0200, Lars Marowsky-Bree wrote:
> But yes, scalability, at least roughly O(foo) guesstimates, for numbers
> of locks and/or number of nodes would be helpful, both for a) speed, but
> also b) number of network messages involved, for recovery and lock
> acquisition.
> 
> Mark, do you have the data you ask for for OCFS2's DLM?
The short answer is no but that we're collecting them. Right now, I can say
that if you take our whole stack into consideration OCFS2 for things like
kernel untars and builds (a common test over here), is typically almost as
fast as ext3 (single node obviously) even when we have a second or third
node mounted.

As far as specific DLM timings go, we're in the process of collecting them.
As you know, lately we have been deep in a process of stabilizing things :)
While we have collected timings independent of the FS in the past, we
haven't done that recently enough that I'd feel comfortable posting it.

> (BTW, trimming quotes is considered polite on LKML.)
Heh, sorry about that - I'll try to do better in the future :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

