Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUJYSoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUJYSoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUJYSnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:43:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59368 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261244AbUJYSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:41:14 -0400
Subject: Re: printk() with a spin-lock held.
From: Lee Revell <rlrevell@joe-job.com>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410250828460.18507@chaos.analogic.com>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
	 <1098503815.13176.2.camel@krustophenia.net>
	 <Pine.LNX.4.61.0410250828460.18507@chaos.analogic.com>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:41:12 -0400
Message-Id: <1098729672.8284.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 08:32 -0400, Richard B. Johnson wrote:
> I recall that printk() useds to just write stuff into a buffer,
> that the buffer (the same buffer used for dmesg), was written
> out only when it was safe to do so.
> 
> 
> Now, if printk() can't do that anymore, how does one de-bug
> ISR code? Or do you just heave it off the cliff and hope that
> it flies?

No, it can, I was wrong.  I was thinking of some other function.

Lee

