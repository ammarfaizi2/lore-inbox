Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWJIT7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWJIT7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWJIT7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:59:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26792 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964802AbWJIT7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:59:49 -0400
Subject: Re: [PATCH 08/10] -mm: clocksource: initialize list value
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006185457.308808000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185457.308808000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:59:46 -0700
Message-Id: <1160423986.5458.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment (clocksouce_list_init.patch)
> A change to clocksource initialization. It's optional for new clocksources,
> but prefered. If the list field is initialized it allows clocksource_register 
> to complete faster since it doesn't have the scan the list of clocks doing 
> strcmp on each.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

I dont' have any comments that haven't been said:

Drop the CLOCKSOURCE_LIST_INIT define, and make it required. Its easy
enough to add.

thanks
-john



