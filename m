Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTELE4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTELE4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:56:11 -0400
Received: from holomorphy.com ([66.224.33.161]:7087 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261895AbTELE4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:56:11 -0400
Date: Sun, 11 May 2003 22:08:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Robert Love <rml@tech9.net>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030512050840.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peter@chubb.wattle.id.au>, Robert Love <rml@tech9.net>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <493798056@toto.iv> <16063.11081.433006.407544@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16063.11081.433006.407544@wombat.chubb.wattle.id.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"William" == William Lee Irwin, <William> writes:
William> Not at all. Just stamp at wakeup and difference when it runs.


On Mon, May 12, 2003 at 03:04:09PM +1000, Peter Chubb wrote:
> That then doesn't include interrupt latency.  The nice thing about the
> amlat tests is that the test predicts when the next interrupt should
> occur, then measures the time between that prediction and the process
> running in userspace.  If you just timestamp at wakeup, you miss all
> the time between interrupt generation and noticing that the process is
> to wake up.

Of course. But that is not the scheduler's problem.


-- wli
