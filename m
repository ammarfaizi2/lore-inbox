Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVCQA0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVCQA0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVCQAZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:25:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:10400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbVCQAZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:25:11 -0500
Date: Wed, 16 Mar 2005 16:23:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, shemminger@osdl.org, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, cliffw@osdl.org, tytso@mit.edu,
       rddunlap@osdl.org
Subject: Re: [5/9] [TUN] Fix check for underflow
Message-ID: <20050317002359.GJ5389@shell0.pdx.osdl.net>
References: <20050316235502.GD5389@shell0.pdx.osdl.net> <4238CBA8.1050807@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4238CBA8.1050807@trash.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy (kaber@trash.net) wrote:
> Chris Wright wrote:
> >-stable review patch.  If anyone has any objections, please let us know.
> >
> 
> I agree to both patches and additionally propose this one.
> It fixes a crash when reading /proc/net/route (netstat -rn)
> while routes are changed. I've seen two bugreports of users
> beeing hit by this bug, one for 2.6.10, one for 2.6.11.

Thank you Patrick, I think we can sneak this in as 10/9 ;-)

thanks,
-chris
