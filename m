Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTIYG3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTIYG3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 02:29:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:46232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261713AbTIYG3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 02:29:20 -0400
Date: Wed, 24 Sep 2003 23:29:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: overridex@punkass.com, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
Message-Id: <20030924232912.7e41d9f9.akpm@osdl.org>
In-Reply-To: <200309250012.48522.dtor_core@ameritech.net>
References: <1064459037.19555.3.camel@nazgul.overridex.net>
	<200309250012.48522.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Could you please try the following patch (it is incremental against the 
>  previous one and should apply to the -mm)

I ran that patch[1] past Vojtech yesterday and he then fixed the problem
which it was addressing by other means within his tree.

So what we should do is to ask Vojtech to share that change with us so Dan
can test it, please.


[1] ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm4/broken-out/joydev-exclusions.patch

