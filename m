Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUCOSEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCOSDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:03:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:11218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262651AbUCOSCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:02:52 -0500
X-Authenticated: #1226656
Date: Mon, 15 Mar 2004 19:02:49 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 on Alpha uninterruptible sleep of processes
Message-Id: <20040315190249.19263f4f@vaio.gigerstyle.ch>
In-Reply-To: <20040315145145.A31703@jurassic.park.msu.ru>
References: <20040312154613.7567adab@hdg.gigerstyle.ch>
	<20040312182754.A680@jurassic.park.msu.ru>
	<20040312184115.B680@jurassic.park.msu.ru>
	<20040312165907.626d4a08@hdg.gigerstyle.ch>
	<20040312224649.A750@den.park.msu.ru>
	<20040312215215.1041889a@hdg.gigerstyle.ch>
	<20040313020141.B4021@den.park.msu.ru>
	<20040313111021.4af73b9e@hdg.gigerstyle.ch>
	<20040314170627.A11159@den.park.msu.ru>
	<20040314195203.78abbef9@vaio.gigerstyle.ch>
	<20040315145145.A31703@jurassic.park.msu.ru>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004 14:51:45 +0300
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Sun, Mar 14, 2004 at 07:52:03PM +0100, Marc Giger wrote:
> > No, it doesn't. After some hours it has got the same problems.
> 
> Fine, at least semaphores changes are innocent. :-)
> 
> Interesting - I wasn't able to reproduce these problems with
> recent kernels on my boxes (including one lx164)...

How long did you let your machine run? In my case, it has to run the
whole night until it happens. I don't know if it helps but I think the
first processes that are in uninterruptible sleep are apache and mysql.
Also, as you can see in my first e-mail (ps -aux output), the pdflush
and kswapd0 are in in uninterruptible sleep state.

Regards

Marc
