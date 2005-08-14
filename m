Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVHNVA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVHNVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVHNVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:00:56 -0400
Received: from waste.org ([216.27.176.166]:56796 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932298AbVHNVA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:00:56 -0400
Date: Sun, 14 Aug 2005 14:00:10 -0700
From: Matt Mackall <mpm@selenic.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Subject: Re: [PATCH 0/8] netpoll: various bugfixes
Message-ID: <20050814210010.GU12284@waste.org>
References: <1.502409567@selenic.com> <20050812172151.GA11104@suse.de> <20050812192152.GJ12284@waste.org> <20050812193109.GA15434@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812193109.GA15434@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 09:31:09PM +0200, Olaf Hering wrote:
>  On Fri, Aug 12, Matt Mackall wrote:
> 
> > Does the task dump work without patch 5/8 (add retry timeout)? I'll
> > try testing it here.
> 
> I spoke to soon, worked once, after reboot not anymore. Will try to play
> with individual patches. Does the task dump work for you, at least?

Works flawlessly on e1000. Works on tg3 with serial console, but seems
to cause trouble without. Haven't had time to dig deeper yet.

-- 
Mathematics is the supreme nostalgia of our time.
