Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVKGSZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVKGSZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVKGSZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:25:59 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:27620 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S964891AbVKGSZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:25:58 -0500
Message-ID: <436F9C1C.4090003@nortel.com>
Date: Mon, 07 Nov 2005 12:25:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler parameter inheritance on clone() -- correction
References: <436F8A06.7090409@nortel.com>
In-Reply-To: <436F8A06.7090409@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 18:25:33.0676 (UTC) FILETIME=[A424B2C0:01C5E3C8]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:
> 
> The pthreads standard specifies that the default behaviour is that new 
> threads should be created with the SCHED_OTHER policy and a priority of 0.

Sorry, I've since found out that this was actually an issue with the man 
pages (same problem on two different distros).  The man pages were still 
from LinuxThreads, but the NPTL behaviour was different.

Apparently the spec doesn't actually specify the default behaviour, it's 
implementation dependent.

My mistake.

Chris
