Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263241AbVBDKpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbVBDKpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbVBDKpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:45:34 -0500
Received: from quechua.inka.de ([193.197.184.2]:2439 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263355AbVBDKpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:45:24 -0500
From: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Huge unreliability - does Linux have something to do with it?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <5a2cf1f605020401037aa610b9@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Cx0xm-0000GD-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 04 Feb 2005 11:45:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5a2cf1f605020401037aa610b9@mail.gmail.com> you wrote:
> I halted the machine correctly yesterday night. I never dropped the
> box in 3 years. Am I just being unlucky? Or could the fact that I am
> using Linux on the box affect the reliability in some ways on that
> particular hardware (Dell Inspiron 8100)? I run Linux on 3 other
> computers and never had single problems with them.

There are a lot of possible problems with your actual hardware. Like
Interrupt handling, power control, dma, ... Those are seldom but possible.
Notebooks tend to require some special handling.

> Could a hardware failure look like bad sectors to fsck?

A failure of the bus or a former sporadic error can cause defective fs, but
normally you have a read error in fsck no structure error.

Are you using hdparm? is the system perhaps overheating or overclocked?

Greetings
Bernd
