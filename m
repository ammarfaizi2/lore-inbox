Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbTITCdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTITCdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 22:33:11 -0400
Received: from holomorphy.com ([66.224.33.161]:6622 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261658AbTITCdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 22:33:09 -0400
Date: Fri, 19 Sep 2003 19:34:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Wendel <jwendel10@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ATTN IBM Guys] NMI count on X440 box
Message-ID: <20030920023415.GD4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Wendel <jwendel10@comcast.net>, linux-kernel@vger.kernel.org
References: <20030919193103.1d08fbff.jwendel10@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919193103.1d08fbff.jwendel10@comcast.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 07:31:03PM -0700, John Wendel wrote:
> I just noticed that our 8-way X440 is showing (in /proc/interrupts)
> about 100 NMIs / second, on each CPU. Would some kind soul please tell
> me if this is OK? A brief explanation of what this interrupt is being
> used for would be appreciated.
> We're running the latest RH Advanced server kernel.
> </curious>
> Sorry if this is a stupid question.

A common use for intentional NMI's is NMI-based profiling, i.e. oprofile.
I can't say for sure this is where your NMI's are coming from without
seeing more about your kernel.


-- wli
