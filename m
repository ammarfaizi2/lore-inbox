Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268571AbUHLN7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268571AbUHLN7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268572AbUHLN7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:59:04 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7637 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268571AbUHLN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:58:55 -0400
Subject: Re: Linux SATA RAID FAQ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1BvFmM-0007W5-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092315392.21994.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 13:56:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 14:38, Bernd Eckenfels wrote:
> Speaing of that, does that mean that other OSes (i.e. Windows) are using
> BIOS provided code to do raid, or do they also have raid software drivers
> and the bios is only used on bootup for signature detection and formatting?

Normally BIOS and windows drivers doing their raid. It isn't entirely
that simple. The 3ware is hardware raid as are some of the other high
end devices (eg aacraid sata boards). There are also some low end
devices with part of the raid logic in hardware (some promise) although
I don't believe we use that to the full yet.

I'm currently trying to fix up the IT8212 which is an older PATA board
which does have real h/w raid 0/1

Alan

