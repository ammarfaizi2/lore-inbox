Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTKHRjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTKHRjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:39:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11652 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261892AbTKHRje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:39:34 -0500
Message-ID: <3FAD2A40.4040700@pobox.com>
Date: Sat, 08 Nov 2003 12:39:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       manfred@dbl.q-ag.de
Subject: Re: [PATCH 2.4] forcedeth
References: <3FAC837F.2070601@gmx.net>
In-Reply-To: <3FAC837F.2070601@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Attached is forcedeth: A new driver for the ethernet interface of the
> NVIDIA nForce chipset, licensed under GPL.
> 
> The driver was written without support from NVIDIA, it's the result of
> a cleanroom development:
> Carl-Daniel and Andrew reverse engineered the nvnet driver and wrote a
> specification, Manfred wrote the driver based on the spec. Since the
> driver has been available and working for a while now, Carl-Daniel
> fitted some compat glue to make it compile under 2.4.
> 
> This release it intended for developers, it's alpha quality: normal
> network traffic could work, although slow due to incomplete interrupt
> handling. It does work on two nForce 2 systems, nForce and nForce 3
> are untested.


Neat!  I saw Manfred posted this driver for 2.6.x, as well.  I'm glad 
soembody FINALLY got around to supporting this chipset under Linux.

Anyway, even with an alpha-quality driver, it's a driver that works 
where otherwise the kernel doesn't.  So, after I review the driver, I 
would prefer to merge it soon rather than later.  It gets users going, 
after all.

Has nVidia yelled yet?  Since it's cleanroom, according to you, I don't 
see any problems at all...

	Jeff



