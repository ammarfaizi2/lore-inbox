Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUHXAmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUHXAmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUHXAkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:40:49 -0400
Received: from fmr99.intel.com ([192.55.52.32]:51622 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S267514AbUHWTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:45:07 -0400
Subject: Re: [RFC] Bus Resource Management
From: Len Brown <len.brown@intel.com>
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rml@ximian.com,
       mochel@digitalimplant.org
In-Reply-To: <20040819133550.GH3824@neo.rr.com>
References: <20040819133550.GH3824@neo.rr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093289962.17215.45.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Aug 2004 15:39:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 09:35, Adam Belay wrote:

> 2.) Sysfs user interface
> - userspace applications can determine resource usage and
> dependencies.
> - userspace applications can disable and enable devices
> - userspace applications can assign resources to a device
> - userspace applications can pause the operation of a device, and
> rebalance
>   its resources

I agree that run-time hotplug policy and re-balancing would all be very
snappy from user-space - users should be in charge when setting policy. 
Heck, humans may even be needed to make some decisions regarding
resource conflicts...

But I'm wondering where the proper line is between that and the resource
management that we have to do on boot before user-space exists.

cheers,
-Len


