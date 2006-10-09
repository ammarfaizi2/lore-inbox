Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWJITpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWJITpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWJITpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:45:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25494 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751650AbWJITpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:45:16 -0400
Subject: Re: [PATCH 06/10] -mm: clocksource: add block notifier
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006185456.995993000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.995993000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:45:12 -0700
Message-Id: <1160423113.5458.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment
> (clocksource_add_block_notify_on_new_clock.patch)
> Adds a call back interface for register/rating change
> events.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

This one looks interesting, but I'm not sure if we yet have the use-case
really needed to implement notifier infrastructure (taking the comments
from my last discussion). I don't really have any criticism with the
code, I just worry it might be over-doing it.

Maybe it would be more persuasive if it went together with the first
users of it, rather then as a independent infrastructure buildup patch.

thanks
-john





