Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEIGHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEIGHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:07:44 -0400
Received: from holomorphy.com ([66.224.33.161]:56477 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262297AbTEIGHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:07:40 -0400
Date: Thu, 8 May 2003 23:20:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509062008.GT8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com> <3EBB4735.30701@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB4735.30701@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Try the timebase instead.

On Fri, May 09, 2003 at 02:14:13AM -0400, Chris Friesen wrote:
> The timestamp is not hard to get.  The problem is getting a 
> medium-frequency (2KHz or so) hardware interrupt to drive the test.
> On intel, you can do this by programming /dev/rtc.  This does not work in 
> powerpc.

I don't understand why you're obsessed with interrupts. Just run your
load and spray the scheduler latency stats out /proc/


-- wli
