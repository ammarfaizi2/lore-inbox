Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272129AbRIEM2K>; Wed, 5 Sep 2001 08:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272130AbRIEM2A>; Wed, 5 Sep 2001 08:28:00 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:8711 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S272129AbRIEM1w>; Wed, 5 Sep 2001 08:27:52 -0400
Message-Id: <200109051227.f85CRwe27842@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: reliable debug output
Date: Wed, 5 Sep 2001 14:27:57 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15ebCR-0005eF-00@the-village.bc.nu>
In-Reply-To: <E15ebCR-0005eF-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do i need klogd?

On Wednesday 05 September 2001 13:50, Alan Cox wrote:
> > when debugging drivers using printk i've the problem that most often
> > the msg passed to printk don't show up on the console since the machine
> > crashed before. i also what to use my own ASSERT macros which halt the
>
> printk writes to the console synchronously unless you have configured
> syslogk to process the messages and log them itself. You may want to boot
> with syslogk disabled and see if that is your problem.
>
> 2.4 also supports serial console which can be useful when the box insists
> on crashing in X11
