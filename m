Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUA0Fwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUA0Fwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:52:38 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45280 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262308AbUA0Fwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:52:35 -0500
Message-ID: <4015FC93.1060804@nortelnetworks.com>
Date: Tue, 27 Jan 2004 00:52:19 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
References: <20040126215036.GA6906@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> I've released the 015 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz

> Also in this release is the start of a udev daemon.  It's really in 3
> pieces:
> 	udevsend - sends the hotplug message to the udev daemon
> 	udevd - the udev daemon, gets the hotplug messages, sorts them
> 		in proper order, and passes them off to the udev program
> 		to act apon them.
> 	udev - still the same.

I'm curious about the rationale behind breaking it up into multiple chunks.

udevsend being separate I assume is so that it can be easily called from 
a script while still keeping something persistant?

I'm not sure I see what separating udev and udevd into different 
binaries actually buys you.  Wouldn't it be just as easy to make udev be 
the daemon based on runtime options or something?

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

