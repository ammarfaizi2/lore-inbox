Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbUKLIAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUKLIAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 03:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbUKLIAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 03:00:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48003 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262490AbUKLIAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 03:00:03 -0500
Date: Fri, 12 Nov 2004 09:00:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Fix sysdev time support
Message-ID: <20041112080000.GC6307@atrey.karlin.mff.cuni.cz>
References: <1100213485.6031.18.camel@desktop.cunninghams> <1100213867.6031.33.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100213867.6031.33.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix type of sleep_start, so as to eliminate clock skew due to math
> errors.

Are you sure? I do not think long signed/unsigned problem can skew the
clock by 1hour. I could see skewing clock by few years, but not by one
hour...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
