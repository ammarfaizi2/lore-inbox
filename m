Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUEKBJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUEKBJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 21:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUEKBJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 21:09:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30203 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262897AbUEKBJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 21:09:14 -0400
Message-ID: <40A027B5.6020505@mvista.com>
Date: Mon, 10 May 2004 18:09:09 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synchronous hotplug for kobjects
References: <20040510204813.GA20691@dhcp193.mvista.com> <20040510211959.GB10887@kroah.com>
In-Reply-To: <20040510211959.GB10887@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> How about I wait until someone really needs this function before adding
> it?  Or do you have a patch that does need it?

I've just sent a patch for system suspend/resume notifiers that uses it. 
If that patch isn't accepted then sounds like this could wait.  Device 
power state change notifiers were also discussed recently, which would 
also use kobject synchronous hotplug if accepted, but the fate of that 
notifier is in doubt.  Thanks -- Todd


