Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbULFXBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbULFXBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULFXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:01:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:29194 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261482AbULFXBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:01:33 -0500
Date: Mon, 6 Dec 2004 23:48:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: kernel list <linux-kernel@vger.kernel.org>, coreteam@netfilter.org
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much possible
Message-ID: <20041206224834.GB17946@alpha.home.local>
References: <41B464B3.8020807@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B464B3.8020807@pointblue.com.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 02:54:59PM +0100, Grzegorz Piotr Jaskiewicz wrote:
 
> If someone has argumentation for 5 days timeout, please speak out. In 
> everyday life, router, desktop, server usage 100s is enough there, and 
> makes my life easier, as many other linux admins.

Uhh ?

please try to start 4 xterms through your firewall, then work for 100s in
one of them, then only start to use anyone of the other ones. If it's hung,
maybe you'll remember how low you put the timeout, and think about all those
users coming to you complaining that they only have to stop typing to talk
to someone before they find their xemacs, xterms, etc... dead.

I've seen several firewalls which caused trouble by breaking connections
after 2 hours of idle, while applications used a default keep-alive of 4
hours. Eventhough 5 days may seem a bit long for some usages (eg: frontal
web servers), several hours is not that much for internal firewalls.

Willy

