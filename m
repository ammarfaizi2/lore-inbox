Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCYErg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCYErg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVCYErg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:47:36 -0500
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:26812 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S261288AbVCYErJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:47:09 -0500
Date: Fri, 25 Mar 2005 12:47:04 +0800
From: Bernard Blackham <bernard@blackham.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Collins <matt@signalz.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise SX8 performance issues and CARM_MAX_Q
Message-ID: <20050325044704.GF4300@blackham.com.au>
References: <20050323175707.GA10481@blackham.com.au> <4241F8BA.6070108@pobox.com> <4241FAF9.1080702@signalz.com> <42438EED.4020202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42438EED.4020202@pobox.com>
Organization: Dagobah Systems
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 11:09:17PM -0500, Jeff Garzik wrote:
> >Indeed there does seem to be new firmware out as of 2/23/05. I ran my 
> >tests with the 9/10/04 firmware but I did not adjust the CARM_MAX_Q 
> >value. Do either of you happen to know what firmware revisions you 
> >tested under?

BIOS boot messages didn't seem to indicate a firmware version, but
this card was only available in stock in early March, so its fairly
likely to have the latest firmware (2/23/05).

> The driver should be solid for _at least_ CARM_MAX_Q==31, presuming that 
> the firmware doesn't choke.

We've run it here with CARM_MAX_Q = 32 with a custom stress testing
script and haven't had any incidents so far. CARM_MAX_Q = 33 goes
bad instantly.

> (c) stress the card with fsx, badblocks, iozone, and other tools
>     on -multiple ports- simultaneously.

I'll give those a workout over the weekend and let you know the
results.

Thanks,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>
