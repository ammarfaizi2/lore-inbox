Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUEQWYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUEQWYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUEQWYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:24:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:64678 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263059AbUEQWYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:24:06 -0400
Date: Mon, 17 May 2004 15:26:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 appears to be 3 to 4 times slower than 2.6.5
Message-Id: <20040517152638.42e9085c.akpm@osdl.org>
In-Reply-To: <40A8CB2E.1070108@mrc-bsu.cam.ac.uk>
References: <40A8CB2E.1070108@mrc-bsu.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> wrote:
>
> Another "me too" I'm afraid.  I'm running 2.6.6 on an ordinary UP Athlon 
> system under Gentoo, and it behaves very strangely.  About 3 out of 4 times, 
> it hangs during boot-up, at the "Freeing unused kernel memory" stage, and 
> seems to not get as far as calling init....
> 
> Yesterday, it got past that stage, and the various startup scripts began to 
> run, but *achingly* slowly.  It took about 10 minutes to get most of the 
> network services started, with no login prompt in sight - I got fed up and 
> rebooted then, because I needed to get some work done!

Please try again and if it gets all the way to a login prompt, compare the
contents of /proc/mtrr with 2.6.6-rc3.  Also play around with `top', etc. 
See if there's anything unusual happening.
