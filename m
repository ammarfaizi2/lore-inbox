Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTILEkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTILEkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:40:25 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:59637 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261659AbTILEkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:40:23 -0400
Message-ID: <3F614E36.7030206@genebrew.com>
Date: Fri, 12 Sep 2003 00:40:22 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030908 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: rusty@linux.co.intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Enabling other oom schemes
References: <200309120219.h8C2JANc004514@penguin.co.intel.com> <3F614912.3090801@genebrew.com> <3F614C1F.6010802@nortelnetworks.com>
In-Reply-To: <3F614C1F.6010802@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.152.250.151] at Thu, 11 Sep 2003 23:40:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> If you have real, true strict overcommit, then it can cause you to have 
> errors much earlier than expected.

I was referring to the "strict overcommit" mode described in 
Documentation/vm/overcommit-accounting. To me, it sounded like it was 
describing modes that were alternatives to the proposed kernel panic on 
oom, and I was merely suggesting we use the same /proc/sys/vm method to 
specify oom behavior (maybe a string rather than numeric codes in case 
we have several such options in the future). Apologies if this is not 
related to what Rusty is talking about.

Thanks,
Rahul
--
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

