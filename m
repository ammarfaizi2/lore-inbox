Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUFGXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUFGXor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUFGXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:44:47 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:65224 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265133AbUFGXoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:44:46 -0400
Date: Mon, 7 Jun 2004 18:57:44 -0400
From: Ben Collins <bcollins@debian.org>
To: Sushant Sharma <sushant@cs.unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: when is alloc_skb called
Message-ID: <20040607225744.GA26253@phunnypharm.org>
References: <40C4DE2A.1070008@cs.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C4DE2A.1070008@cs.unm.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 03:29:14PM -0600, Sushant Sharma wrote:
> Hi All
> 
> I want to know which are the evnets
> that can lead to the calling of alloc_skb
> function which is used to allocate sk_buff.
> Arrival and departure of packet are 2 events
> which I know. Are there any other events/cases
> which can lead to alloc_skb(...) function call in kernel.

Some non-network related drivers use skb's for non-network related
things (ieee1394 is one such abuser).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
