Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVFRV7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVFRV7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFRV7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 17:59:37 -0400
Received: from bay104-f6.bay104.hotmail.com ([65.54.175.16]:59179 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262171AbVFRV71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 17:59:27 -0400
Message-ID: <BAY104-F697F218C7E4E45B78BCDA84F70@phx.gbl>
X-Originating-IP: [65.54.175.204]
X-Originating-Email: [idht4n@hotmail.com]
From: "David L" <idht4n@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: bad: scheduling while atomic!: how bad?
Date: Sat, 18 Jun 2005 14:59:18 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2005 21:59:19.0381 (UTC) FILETIME=[FA337850:01C57450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the message:

bad: scheduling while atomic!

I see this dozens of times when I'm writing to a nand flash device using a 
vendor-provided driver from Compulab in 2.6.8.1.  Does this mean the driver 
has a bug or is incompatible with the preemptive configuration option?  How 
bad is "bad"?  Should I turn of the preemption option, ignore the message, 
or what?

Thanks...

                      David

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

