Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267776AbUIUR4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267776AbUIUR4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUIUR4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:56:21 -0400
Received: from mail.tmr.com ([216.238.38.203]:15632 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267776AbUIUR4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:56:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Date: Tue, 21 Sep 2004 13:57:14 -0400
Organization: TMR Associates, Inc
Message-ID: <cippij$g5l$1@gatekeeper.tmr.com>
References: <1095721742.5886.128.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1095788948 16565 192.168.12.100 (21 Sep 2004 17:49:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <1095721742.5886.128.camel@bach>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell (IBM) wrote:
> Name: Warn that ipchains and ipfwadm are going away
> Status: Trivial
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> At the recent netfilter workshop in Erlangen, we was decided to remove
> the backwards compatibility code for ipchains and ipfwadm.  This will
> allow significant cleanup of interfaces, since we had to have a
> mid-level interface for the backwards compatibility layer to use.
> 
> Start off with a warning for 2.6.9, so any remaining users have a
> chance to migrate.  Their firewall scripts might not check return
> values, and they might get a nasty surprise when this goes away.

I thought I understood the "new development model" but I guess I don't. 
Are working features now going to be removed from the "stable" chain 
instead of during a development cycle?

Not a complaint, I thought the new method was regarding new features...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
