Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTHRTAT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTHRTAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:00:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27155 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272258AbTHRS7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:59:07 -0400
Date: Mon, 18 Aug 2003 19:59:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
Message-ID: <20030818195903.G1737@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030818192831.E1737@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308181141010.5929-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308181141010.5929-100000@home.osdl.org>; from torvalds@osdl.org on Mon, Aug 18, 2003 at 11:47:14AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:47:14AM -0700, Linus Torvalds wrote:
> I'd be interested to hear whether the dang things work. Of course, there 
> probably aren't that many people around with the hardware any more. I 
> could just have added them to the BROKEN list, but since they _might_ work 
> it seemed like a better idea to be hugely optimistic instead ;)

True.  However, there is the opposite point of view which is equally
valid.  There aren't many people with the hardware, and the people
that there are aren't interested in development kernel series, so
even if we did convert them during 2.7, we wouldn't hear about it
until 2.8.

IMO its far better to do these types of conversions when users are
interested in the driver (and can therefore give you bug reports)
than when they are actively ignoring the development series.

Both positions are equally valid.  I'm not going to argue that one
is more valid than the other because I have enough on my plate for
the time being. 8)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

