Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUGYV7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUGYV7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUGYV7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:59:39 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:29670 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264530AbUGYV7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:59:37 -0400
Date: Sun, 25 Jul 2004 23:59:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040725235927.B30025@electric-eye.fr.zoreil.com>
References: <4102CF17.2010207@marcansoft.com> <Pine.LNX.4.44.0407252300170.1794-100000@silmu.st.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407252300170.1794-100000@silmu.st.jyu.fi>; from ptsjohol@cc.jyu.fi on Sun, Jul 25, 2004 at 11:27:04PM +0300
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Sjoholm <ptsjohol@cc.jyu.fi> :
[...]
> I haven't been able to reproduce this with normal www-browsing or 
> ssh-connections but it's always reproducible when my eth0 is under heavy 
> load.

I guess it can be reproduced even if the binary (nvidia ?) module is never
loaded after boot, right ?

[...]
> Same thing for me also, except for me it's interrupt 10 (CMI8738-MC6, 
> eth0), so it's pointing more and more something rtl-8139 related.

Possible. Which 8139 module do you use ?

It would be nice if this thread could be fed to netdev@oss.sgi.com.

--
Ueimor

