Return-Path: <linux-kernel-owner+w=401wt.eu-S932470AbXAGKOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXAGKOv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbXAGKOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:14:51 -0500
Received: from mail.macqel.be ([194.78.208.39]:19564 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470AbXAGKOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:14:50 -0500
Date: Sun, 7 Jan 2007 11:14:49 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RTC subsystem and fractions of seconds
Message-ID: <20070107101449.GA24163@ingate.macqel.be>
References: <200701051949.00662.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701051949.00662.david-b@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 07:49:00PM -0800, David Brownell wrote:
> >  	Those rtc's actually have a 1/100th of second
> > register.  Should the generic rtc interface not support that?
> 
> Are you implying a new userspace API, or just an in-kernel update?
> 
> Either way, that raises the question of what other features should
> be included.  What sub-second precision?  Multiple alarms?  Ways
> to manage output clocks?  Sub-HZ periodic alarms?

One usefull addition for my needs and with a m41t81 is the support of
the calibration of the rtc.  However this can perhaps be hidden in the
.set_mmss function.

Philippe

-- 
