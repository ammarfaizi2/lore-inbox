Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWFZSCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWFZSCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWFZSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:02:47 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:48012 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932455AbWFZSCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:02:45 -0400
Date: Mon, 26 Jun 2006 20:02:44 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chris Rankin <rankincj@yahoo.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.17: PMTimer results for another PCI chipset
Message-ID: <20060626180244.GA6898@rhlx01.fht-esslingen.de>
References: <20060626120847.GA6272@rhlx01.fht-esslingen.de> <20060626174412.76248.qmail@web52905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626174412.76248.qmail@web52905.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 26, 2006 at 06:44:12PM +0100, Chris Rankin wrote:
> --- Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > Yeah, but this is no problem anyway, since it's neither in the blacklisted
> > nor in the graylisted area, IOW it's whitelisted and should work
> > without delays.
> > Or do you get the "The chipset may have PM-Timer Bug" message here??
> > 
> > > 00:1f.0 Class 0601: 8086:2440 (rev 05)
> > 
> > #define PCI_DEVICE_ID_INTEL_82801BA_0   0x2440
> 
> Nope, it's all good. But since this chipset was released between the one which definitely has the
> bug and one which might have the bug, I thought that it was worth testing it for real.

Oh, then it's a very valid concern indeed!
Thanks for verifying that it doesn't seem to be a problem here.
(however, given the SMM/SMI BIOS fixups as pointed out by Albert Cahalan,
there might still be an issue with this chipset)

Andreas Mohr
