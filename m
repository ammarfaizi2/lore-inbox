Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTILWLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTILWLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:11:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:45205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261914AbTILWLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:11:45 -0400
Date: Fri, 12 Sep 2003 14:53:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: pacman@mscc.huji.ac.il, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test5-mm1
Message-Id: <20030912145330.3d223594.akpm@osdl.org>
In-Reply-To: <20030912215431.GG30584@matchmail.com>
References: <3F61C062.1080700@mscc.huji.ac.il>
	<20030912112436.03ba9dd1.akpm@osdl.org>
	<20030913022909.3a18f6fa.pacman@mscc.huji.ac.il>
	<20030912215431.GG30584@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> On Sat, Sep 13, 2003 at 02:29:09AM +0300, Voicu Liviu wrote:
> > Thank you, I have found the problem, my sound card is Ensoniq ES1371 so
> the module should be snd_ens1371 but I used to load by mistake snd_ens1370
> so I got the OOPS all the time, I fixed the alsa-config and now all works.  
> > Liviu
> 
> Please try snd_ens1370 with the patch Andrew posted and see if it still
> oopses.  We need to know if it fixes the problem you are having, even if you
> were using the wrong driver for your hardware.

No further testing is needed thanks.  Both bugs have been found.

