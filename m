Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbVBCVAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbVBCVAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbVBCVAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:00:50 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:40865 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S263172AbVBCVAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:00:34 -0500
Message-ID: <420290ED.8020302@candelatech.com>
Date: Thu, 03 Feb 2005 13:00:29 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:

> All I want to do is to have a module that would create subdirectories 
> for some network interfaces under /sys/class/net/*/, which would contain 
> additional parameters for those interfaces.  I'm not creating a new 
> subsystem or anything like that.  sysctl is not good because the data is 
> interface specific.  ioctl on a socket would be OK, although it wouldn't 
> be easily scriptable.  The restriction on sysfs symbols would just force 
> me to write a proprietary userspace utility to set those parameters 
> instead of using a shell script.

How about /proc/net/pavelStuff

Still scriptable, and does not require GPL symbols....

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

