Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWDSQCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWDSQCI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWDSQCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:02:08 -0400
Received: from stinky.trash.net ([213.144.137.162]:52655 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750962AbWDSQCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:02:05 -0400
Message-ID: <44465E58.4000509@trash.net>
Date: Wed, 19 Apr 2006 17:59:20 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, markus.lidel@shadowconnect.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [2.6 patch] drivers/message/i2o/iop.c: static inline functions
 mustn't be exported
References: <20060418150615.GH11582@stusta.de> <20060418230600.4bccd221.akpm@osdl.org> <20060419083344.GA25047@stusta.de>
In-Reply-To: <20060419083344.GA25047@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> But this doesn't mean it's OK - exporting static code is wrong.
> 
> BTW:
> It seems Patrick's recently merged patch to let the compiler help us 
> find such bugs (a1a8feed1743ec8d2af1dafa7c5321679f0a3e4f) isn't working.

Indeed, something seems to be broken. I can't get it to throw warnings
anymore even for the H.323 case I initially tested it with, which is
strange because I did trial and error until I had something which I'm
100% sure did throw warnings. I'll look into it, thanks.
