Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUBAPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265389AbUBAPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:34:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:10395 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265377AbUBAPeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:34:25 -0500
Subject: Re: rio500 driver broken in linux 2.6.x
From: "Yury V. Umanets" <umka@namesys.com>
To: Florian Engelhardt <dot@dot-matrix.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040128143123.69b6f281@HAL2000>
References: <20040128143123.69b6f281@HAL2000>
Content-Type: text/plain; charset=ISO-8859-1
Organization: NAMESYS
Message-Id: <1075649682.2066.37.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 01 Feb 2004 17:34:42 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-28 at 15:31, Florian Engelhardt wrote:
> Hello,
> 
> the rio500 driver seems to be broken, more and more people are talkin
> about it. I allready wrote a mail to the maintainer of this dirver but
> i got no response. The mailinglist which i found in the
> /usr/src/linux/MAINTAINERS file is dead.
> The Bug:
> You con compile the driver without proplems, and when you connect the
> rio500 to the usb bus, the kernel reports that he found it. But you can
> not do any operations on it with the rio500 utils from sourceforge.
> If i try to upload a file, or to create a folder on the rio500 the
> connection to the player freezes and when i´m not killing the process,
> the system hangs.
> Does anyone of you know about this problem?
> The problem depends on the new kernel, couse with the 2.4.x kernel there
> are no problems with the rio utils from sourceforge.
I also have experienced problem with this driver quite ago... in the
times of last test kernels. I have used it (with trivial changes) for
accessing my mpio player.

Probably this is not what you are expecting to hear, but seems that this
driver is going to be obsolete. It does not do something special that
cannot be done in user-space using libusb. So, probably there is no
reason to fix it. Somebody should add libusb support to rio user-space
tools like it was done for mpio ones (mpio.sf.net).

> 
> Regards
> 
> Florian Engelhardt
-- 
umka

