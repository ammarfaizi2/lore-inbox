Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJETqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJETqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJETm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:42:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58265 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266459AbUJETlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:41:11 -0400
Date: Tue, 5 Oct 2004 21:37:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Message-ID: <20041005193737.GD4723@openzaurus.ucw.cz>
References: <200410041400.04385.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410041400.04385.david-b@pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This lets drivers standardize how they present their ability to issue
> wakeups, and how they manage whether that ability should be used.

Why do you assign "enabled" to variable instead of using it directly?
And perhaps you should print "not supported" instead of empty string...

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

