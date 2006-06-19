Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWFSEcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFSEcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWFSEcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:32:22 -0400
Received: from ns.theshore.net ([67.18.92.50]:59590 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S1750751AbWFSEcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:32:22 -0400
Message-ID: <449628CB.6050206@theshore.net>
Date: Sun, 18 Jun 2006 23:32:11 -0500
From: "Christopher S. Aker" <caker@theshore.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: user-mode-linux-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] 2.6.17-um - new uptime record (40 years!)
References: <44961CC8.1060302@theshore.net>
In-Reply-To: <44961CC8.1060302@theshore.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher S. Aker wrote:
> root@none:~ # uname -a
> Linux none 2.6.17-linode20 #1 Sun Jun 18 00:04:18 EDT 2006 i686 GNU/Linux
> root@none:~ # uptime
>   23:37:50 up 14663 days, 20:54,  1 user,  load average: 0.00, 0.00, 0.00
> root@none:~ # cat /proc/uptime
> 1266958484.15 69449.04
> 
> -Chris

OK, 2.6.17 final missed Jeff's "Fix wall_to_monotonic initialization" 
patch...

http://marc.theaimsgroup.com/?l=linux-kernel&m=115016859504778&w=2

I can confirm that this fixes the issue.  Queue this sucker up for the 
next stable release!

I hope nothing else was missed, but so far this is the only snag we've 
hit with 2.6.17-um.  Rock on!  Maybe now I can finally stop making new 
deployments default to 2.4-um.

-Chris
