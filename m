Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTEIABL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbTEIABL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:01:11 -0400
Received: from holomorphy.com ([66.224.33.161]:63643 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261359AbTEIABK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:01:10 -0400
Date: Thu, 8 May 2003 17:13:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509001339.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
References: <3EBAD63C.4070808@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBAD63C.4070808@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 06:12:12PM -0400, Chris Friesen wrote:
> I'm trying to test the scheduler latency on a powerpc platform.  It appears 
> that a realfeel type of program won't work since you can't program /dev/rtc 
> to generated interrupts on powerpc.  Is there anything similar which could 
> be done?

Why would you want to use an interrupt? Just count jiffies in sched.c


-- wli
