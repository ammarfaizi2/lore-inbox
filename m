Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTE2IbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 04:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTE2IbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 04:31:01 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:42130 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S262011AbTE2IbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 04:31:00 -0400
Date: Thu, 29 May 2003 10:44:10 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Milton Miller <miltonm@bga.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
Message-ID: <20030529084410.GA11885@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Milton Miller <miltonm@bga.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller, Wed, May 28, 2003 08:43:27 +0200:
> 
> Didn't know if you caught this one, but it fixes it for me and others
> who responded on the list.  
> 

it fixes the oops after restoring from suspend,
but the system still became unstable: random segfaults, random oopses.

