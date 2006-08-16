Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWHPUoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWHPUoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWHPUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:44:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:38878
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750903AbWHPUod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:44:33 -0400
Date: Wed, 16 Aug 2006 13:44:33 -0700 (PDT)
Message-Id: <20060816.134433.59657101.davem@davemloft.net>
To: kkeil@suse.de
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060816203935.GB1040@pingi.kke.suse.de>
References: <20060815160657.GA14266@pingi.kke.suse.de>
	<9a8748490608161322q64e7d48fmbdf68288db22b64e@mail.gmail.com>
	<20060816203935.GB1040@pingi.kke.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Keil <kkeil@suse.de>
Date: Wed, 16 Aug 2006 22:39:35 +0200

> Was here any trigger for your patch ?

I think Jesper didn't have a test case, but rather spotted
this visually.
