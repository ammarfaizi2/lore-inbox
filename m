Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752103AbWCNC3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbWCNC3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbWCNC3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:29:12 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:8920 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1752099AbWCNC3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:29:11 -0500
Subject: Re: [Patch 9/9] Generic netlink interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <1142297791.5858.31.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: unknown
Date: Mon, 13 Mar 2006 21:29:09 -0500
Message-Id: <1142303349.5219.19.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-13-03 at 19:56 -0500, Shailabh Nagar wrote:
> delayacct-genetlink.patch
> 
> Create a generic netlink interface (NETLINK_GENERIC family), 
> called "taskstats", for getting delay and cpu statistics of 
> tasks and thread groups during their lifetime and when they exit. 
> 
> Comments addressed (all in response to Jamal)
> 

Note, you are still not following the standard scheme of doing things.
Example: using command = GET and the message carrying the TGID to note
which TGID is of interest. Instead you have command = TGID.

cheers,
jamal

