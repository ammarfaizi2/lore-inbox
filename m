Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbTGABQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 21:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265759AbTGABQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 21:16:36 -0400
Received: from ns.mock.com ([209.157.146.194]:43203 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S265757AbTGABQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 21:16:35 -0400
Message-Id: <5.1.0.14.2.20030630175710.01b5be48@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 30 Jun 2003 18:30:53 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jeff Mock <jeff-ml@mock.com>
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1056995562.17567.16.camel@dhcp22.swansea.linux.org.uk>
References: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
 <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1011; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:52 PM 6/30/2003 +0100, Alan Cox wrote:
>On Sul, 2003-06-29 at 23:37, Jeff Mock wrote:
> > I'm running a 2.4.21 kernel on a redhat 9.0 system.
> >
> > I'm having a problem when using serial ATA drives on an Intel 875P/ICH5
> > motherboard where the kernel will hang at approximately the same place
> > in the boot process about 25% of the time.
>
>Set the bios setting to legacy mode

Thank you.  That solved the problem, I've rebooted many times with
no failures.

It's a bit sad to be limited to 4 SATA+PATA devices, but ICH5 SATA
seems to work well on 2.4.21 if the BIOS is in legacy mode.

jeff

