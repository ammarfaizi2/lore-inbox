Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTDFUWm (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTDFUWl (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:22:41 -0400
Received: from smtp.terra.es ([213.4.129.129]:30458 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S263071AbTDFUVu (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:21:50 -0400
Date: Sun, 6 Apr 2003 22:29:59 +0200
From: Arador <diegocg@teleline.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nicku@vtc.edu.hk, linux-kernel@vger.kernel.org
Subject: Re: Debugging hard lockups (hardware?)
Message-Id: <20030406222959.63add445.diegocg@teleline.es>
In-Reply-To: <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
	<1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Apr 2003 19:34:09 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> For the NMI watchdog to fail (if you have it enabled) requires pretty
> major disaster to have occurred since the NMI will be delivered through
> any kind of system hang

I've a similar hang; no oops; no sysrq; no NMI messages;
But mine only happens under 2.5; since long time ago.
The one strange thing is that it seems that it's not hanged;
since the X pointer moves in 3-5 seconds intervals (it even
change the shape in the window's corners).
It happens without X too; but as i said nothing survives...
no oops, sysrq, nmi messages, doesn't answer to pings...

I know by the fans' sound that the cpu usage goes to 100%

I'm thinking of a hardware failure too (but the odd X behaviour makes
me hesitate); since i don't remember that it failed under 2.4 that i
remember of...this box didn't run a lot of 2.4 kernel though.

The box passes memtest86; it's
 a 2x800 box, ide disk, 256 ram;
VIA chipset...just in the (very strange) case that somebody
has exactly the same box and they have/don't have the same problems.
(elitegroup d6vaa motherboard)

Diego Calleja
