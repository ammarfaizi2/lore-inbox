Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTEIGCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTEIGCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:02:30 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:51375 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261618AbTEIGC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:02:29 -0400
Message-ID: <3EBB4735.30701@nortelnetworks.com>
Date: Fri, 09 May 2003 02:14:13 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> Try the timebase instead.

The timestamp is not hard to get.  The problem is getting a medium-frequency 
(2KHz or so) hardware interrupt to drive the test.

On intel, you can do this by programming /dev/rtc.  This does not work in powerpc.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

