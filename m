Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbTILVyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTILVyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:54:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54286
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261611AbTILVyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:54:24 -0400
Date: Fri, 12 Sep 2003 14:54:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test5-mm1
Message-ID: <20030912215431.GG30584@matchmail.com>
Mail-Followup-To: Voicu Liviu <pacman@mscc.huji.ac.il>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <3F61C062.1080700@mscc.huji.ac.il> <20030912112436.03ba9dd1.akpm@osdl.org> <20030913022909.3a18f6fa.pacman@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913022909.3a18f6fa.pacman@mscc.huji.ac.il>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 02:29:09AM +0300, Voicu Liviu wrote:
> Thank you, I have found the problem, my sound card is Ensoniq ES1371 so
the module should be snd_ens1371 but I used to load by mistake snd_ens1370
so I got the OOPS all the time, I fixed the alsa-config and now all works.  
> Liviu

Please try snd_ens1370 with the patch Andrew posted and see if it still
oopses.  We need to know if it fixes the problem you are having, even if you
were using the wrong driver for your hardware.
