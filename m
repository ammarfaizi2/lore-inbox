Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUKIWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUKIWBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUKIWBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:01:41 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:24811 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261718AbUKIWAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:00:39 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 9 Nov 2004 22:43:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
Message-ID: <20041109214354.GA17538@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109211107.GB5892@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As far as I can see, the radio parameter is already handled correctly.
> Is the patch below correct?

> -/* kernel args */
> -#ifndef MODULE
> -static int __init p_radio(char *str) { return bttv_parse(str,BTTV_MAX,radio); }
> -__setup("bttv.radio=", p_radio);
> -#endif

Yes, it's already in Andrew's inbox, just forgot to delete that and
didn't notice due to modular builds ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
