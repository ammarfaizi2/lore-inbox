Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJXAlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTJXAlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:41:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20678 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261931AbTJXAlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:41:50 -0400
Subject: Re: [pm] fix time after suspend-to-*
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1066955396.1122.133.camel@cog.beaverton.ibm.com>
References: <20031022233306.GA6461@elf.ucw.cz>
	 <1066866741.1114.71.camel@cog.beaverton.ibm.com>
	 <20031023081750.GB854@openzaurus.ucw.cz>  <3F9838B4.5010401@mvista.com>
	 <1066942532.1119.98.camel@cog.beaverton.ibm.com>
	 <3F985FB0.1070901@mvista.com>
	 <1066955396.1122.133.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066955970.1118.135.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Oct 2003 17:39:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 17:29, john stultz wrote:
> When we are woken up, we should update the
> system time and continue, but as the box wasn't running during the
> interim we shouldn't be increasing the notion of monotonic time. 

Ack, that should be "update the wall time and continue".

Sorry.

thanks
-john


