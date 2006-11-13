Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754653AbWKMN4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbWKMN4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbWKMN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:56:37 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:7611 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S1754653AbWKMN4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:56:36 -0500
Date: Mon, 13 Nov 2006 14:56:34 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Martin Lorenz <martin@lorenz.eu.org>
cc: Linux-Kernel-Mailinglist <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: paging request BUG in 2.6.19-rc5 on resume - X60s
In-Reply-To: <20061113081147.GB5289@gimli>
Message-ID: <Pine.LNX.4.64.0611131451050.15774@mercury.sdinet.de>
References: <20061113081147.GB5289@gimli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Martin Lorenz wrote:

> here is another one:
>
> I reported a black screen on resume with my latest kernel build earlyer. But
> this was not reproducible. Only occured once.
>
> BUT I suspended with the ipw3945 module loaded once again now and got a BUG
> report in the log instead of a black screen.

I get nearly the same oopses on my thinkpad t60, too.
Always only after resuming (never after a clean reboot), and after the 
(otherwise successfull) resume it can take hours until the oops shows.

Did not report this problem anywhere yet, because I am using a heavily 
modified 2.6.17 based on the ubuntu edgy tree plus lots of addon patches 
(suspend2, linux-vserver, loop-aes) and most of the time with the evil 
fglrx loaded, too (to get any x11 outputs at all).

> I only see this when ipw3945 is loaded.

Will try to shutdown wireless and unload the module before the next 
suspend, and see if it helps.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
