Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTE2WIE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTE2WIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:08:04 -0400
Received: from ip68-3-49-116.ph.ph.cox.net ([68.3.49.116]:40833 "EHLO
	raq.home.iceblink.org") by vger.kernel.org with ESMTP
	id S262930AbTE2WID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:08:03 -0400
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
References: <20030529114001.GD7217@louise.pinerecords.com>
Message-ID: <oprpygljynury4o7@lists.bilicki.com>
Content-Type: text/plain; charset=utf-8; format=flowed
From: Duncan Laurie <duncan@sun.com>
MIME-Version: 1.0
Date: Thu, 29 May 2003 15:25:57 -0700
User-Agent: Opera7.11/Linux M2 build 406
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 13:40:01 +0200, Tomas Szepe <szepe@pinerecords.com> wrote:
>
> I can't seem to get the onboard Serverworks CSB5 IDE controller (rev 93)
> in a Compaq Proliant ML350 G3 to work (reliably/at all) no matter what
> kernel I use:
>

Hi Tomas,

This problem *may* actually be in the hardware...  IIRC the CSB5 rev 93h is
the A2.1 version of the chip which had big problems with DMA.  The workaround
options included a messy rework of the PCB or forcing it into PIO mode, so we
decided instead to just stick with the A2.0 revision. :)

However all of my knowledge about this particular issue is based on >1yr old
information, so if you want to send the output of "lspci -xxx" for pci devices
00:0f.0 and 00:0f.1 I will check them over for any obvious settings the BIOS
may have missed.

-duncan

