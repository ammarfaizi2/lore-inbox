Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUIOWRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUIOWRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIOWPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:15:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:10412 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267664AbUIOWKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:10:12 -0400
Message-ID: <4148BD97.1080504@nortelnetworks.com>
Date: Wed, 15 Sep 2004 16:09:27 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Greg KH <greg@kroah.com>, "Marco d'Itri" <md@Linux.IT>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com> <20040915192134.GA4197@dualathlon.random>
In-Reply-To: <20040915192134.GA4197@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> the kernel certainly knows when it's about time to fork an userspace
> process to create the device, doesn't it? then just wait4 while the
> process is running.

Last I checked, if using udevsend the process that gets forked is not the same 
process that actually creates the device node.

Chris
