Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264090AbUECVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbUECVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUECVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 17:33:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46584 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264090AbUECVdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 17:33:06 -0400
Message-ID: <4096BA8E.4040601@mvista.com>
Date: Mon, 03 May 2004 14:33:02 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
References: <20040429202654.GA9971@dhcp193.mvista.com> <20040429224243.L16407@flint.arm.linux.org.uk> <40918375.2090806@mvista.com> <1083286226.20473.159.camel@gaston> <20040430093012.A30928@flint.arm.linux.org.uk> <4092B02C.5090205@mvista.com> <20040430215621.GA14015@kroah.com> <4092FA66.20704@mvista.com> <20040501014827.GA16006@kroah.com>
In-Reply-To: <20040501014827.GA16006@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> I don't have an objection to add such a new paramater (or even a new
> function call like you suggested), just don't go messing with the main
> kobject hotplug call without thinking everything through :)

OK, will do.

>>This is something that was requested of me by others who build Linux 
>>into consumer electronics devices.  Perhaps some of the interested 
>>parties may speak up here to add more insight.
> 
> 
> Please encourage them to speak up.  I hear _nothing_ from any embedded
> developers, and I am really interested in how the driver model and
> hotplug works (or doesn't) for them.  Without that feedback, we are in
> the dark as to what their needs/hates are.

Thanks, I have passed the call to get involved on to a group of Linux 
consumer electronics developers (the Consumer Electronics Linux Forum; 
Tim Bird will hold a BoF at OLS introducing this group).  I am involved 
at an infrastructure level and have helped steer various general 
requirements toward use of LDM (which we've been using even in 2.4 for 
some time) and hotplug (which is new to us for these purposes and they 
might not yet have much experience with this), and can also serve as a 
conduit for feedback.  I appreciate your interest in the needs of 
embedded developers and hope that we can contribute some useful 
suggestions and features.


-- 
Todd Poynor
MontaVista Software

