Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWFVOvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWFVOvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWFVOvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:51:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61389 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751651AbWFVOvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:51:54 -0400
Subject: Re: [PATCH] fix and optimize clock source update
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606221308200.17704@scrub.home>
References: <Pine.LNX.4.64.0606211434020.904@scrub.home>
	 <1150923519.2690.14.camel@leatherman>
	 <Pine.LNX.4.64.0606212320450.12900@scrub.home>
	 <20060621145104.b13af6aa.akpm@osdl.org>
	 <Pine.LNX.4.64.0606221308200.17704@scrub.home>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 07:51:48 -0700
Message-Id: <1150987909.2670.3.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 13:19 +0200, Roman Zippel wrote:
> This fixes the clock source updates in update_wall_time() to correctly
> track the time coming in via current_tick_length(). Optimize the fast
> paths to be as short as possible to keep the overhead low.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 

Thanks Roman!

The inconsistencies at clocksource change are resolved. I'm having a
real spotty time getting my airo card to work w/ 2.6.17-mm1, so I'll run
more tests w/ ntp later today when I'm wired.

ACKed-by: John Stultz <johnstul@us.ibm.com>

thanks again,
-john

