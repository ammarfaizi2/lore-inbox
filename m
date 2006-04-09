Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWDILny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDILny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 07:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWDILny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 07:43:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:1467 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750729AbWDILny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 07:43:54 -0400
Date: Sun, 9 Apr 2006 15:39:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [-mm patch] drivers/w1/w1.c: fix a compile error
Message-ID: <20060409113950.GA29990@2ka.mipt.ru>
References: <20060408031405.5e5131da.akpm@osdl.org> <20060409113110.GA8454@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060409113110.GA8454@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 09 Apr 2006 15:39:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 01:31:10PM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> This patch fixes the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/w1/w1.o
> drivers/w1/w1.c:197: error: static declaration of 'w1_bus_type' follows non-static declaration
> drivers/w1/w1.h:217: error: previous declaration of 'w1_bus_type' was here
> make[2]: *** [drivers/w1/w1.o] Error 1
> 
> <--  snip  -->
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thank you, Adrian, your patch is correct.

-- 
	Evgeniy Polyakov
