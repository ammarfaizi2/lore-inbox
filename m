Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTDPPoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTDPPnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:43:15 -0400
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:48649 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S264541AbTDPPmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:42:43 -0400
Date: Wed, 16 Apr 2003 09:58:40 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
Message-ID: <20030416095840.A15189@discworld.dyndns.org>
References: <200304161511.h3GFBoe7000614@81-2-122-30.bradfords.org.uk> <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003801c3042e$a6bcbea0$6901a8c0@athialsinp4oc1>; from admin@brien.com on Wed, Apr 16, 2003 at 11:41:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brien <admin@brien.com> wrote:
> 
> I ran Memtest86, and there're 290 errors that showed up from test 7. But the
> thing that I don't understand is, if I use either of the RAM modules alone,
> Linux loads and runs perfectly for as long as I've tried; Could it possibly
> be a problem with something besides the RAM (e.g. motherboard, CPU)?

Putting multiple modules in puts a higher load on the address and data lines
supplying the sockets; apparently those two modules are too much of a load for
your motherboard.  You didn't notice a problem in Windows because it doesn't
push the hardware quite as hard.

If your board supports registered (buffered) DIMMs, that would likely solve
your problem.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
