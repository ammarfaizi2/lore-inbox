Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbUAEMlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUAEMlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:41:51 -0500
Received: from router.k.plenum.de ([194.77.86.125]:27535 "EHLO
	metallica.ki.plenum.de") by vger.kernel.org with ESMTP
	id S264323AbUAEMlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:41:49 -0500
Date: Mon, 5 Jan 2004 13:43:21 +0100
From: Kresimir Sparavec <kreso@k.plenum.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: neel vanan <neelvanan@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic.. in 3.0 Enterprise Linux
Message-ID: <20040105134321.A8565@metallica.ki.plenum.de>
References: <20040105115610.49148.qmail@web9505.mail.yahoo.com> <1073305477.4429.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1073305477.4429.0.camel@laptop.fenrus.com>; from arjanv@redhat.com on Mon, Jan 05, 2004 at 01:24:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 05, 2004 at 01:24:38PM +0100, Arjan van de Ven wrote:
> On Mon, 2004-01-05 at 12:56, neel vanan wrote:
> > Hi all,
> > 
> > The kernel I have working is version 2.4.21-4.EL and I
> > can still boot up to that. I compiled a 2.6.0 version
> > and installed it in exactly the same way that the old
> > version is, just appending 2.6.0 to the end of the
> > file. so when I reboot I get a boot screen that shows:
> > 
> > Red Hat Enterprise Linux AS (2.4.21-4.ELsmp)
> > Red Hat Enterprise Linux As-up (2.4.21-4.EL)
> > Red Hat linux (2.6.0)
> 
> RHEL3 isn't quite 2.6 ready btw; you need to update quite a few packages
> to get it working right.

could you please summarize which ones? i upgraded modutils and modified
rc.sysinit for usb support. the rest works unmodified (except NVIDIA
proprietary kernel driver which does not have 2.6.x support yet, but XFree86
driver works fine for me) as far as i can tell. i got exactly 0 (zero)
kernel panics up to now. compared with 2.4.0 few years ago, 2.6.0 works
like charm

> 
> Also if you use mount-by-label you do need to create an initrd (with a
> 2.6 capable mkinitrd)...
> 
