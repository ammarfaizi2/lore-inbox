Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267000AbUBMNcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267001AbUBMNcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:32:41 -0500
Received: from mail0-96.ewetel.de ([212.6.122.96]:47247 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S267000AbUBMNcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:32:36 -0500
To: hpa@zytor.com (H. Peter Anvin)
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
In-Reply-To: <1oEQf-2nq-7@gated-at.bofh.it>
References: <1lBZb-4vn-23@gated-at.bofh.it> <1lQXH-2pY-7@gated-at.bofh.it> <1mOhm-27W-31@gated-at.bofh.it> <1n4Fj-La-15@gated-at.bofh.it> <1oEQf-2nq-7@gated-at.bofh.it>
Date: Fri, 13 Feb 2004 14:33:19 +0100
Message-Id: <E1ArdRX-00005H-Tf@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 07:20:07 +0100, you wrote in linux.kernel:

>> That's not all correct. You can fit 700 MB data on a CD-ROM, but booting
>> is still emulated from a 1.44 MB floppy (or some other floppy/HDD
>> images, but many BIOSses won't accept those (or handle them correctly)).
> Baloney.  Most BIOSes support "no emulation" booting these days; in fact,
> there are more that don't do floppy emulation correctly than the few very
> old BIOSes which didn't do no emulation.

Even if wanting to support BIOSes that don't do "no emulation", all it
takes is simple initrd to locate and mount the iso9660 filesystem off the
real device - and that easily fits on a 2.88 MB floppy image used for
emulated floppy boot. Should also fit on an 1.44 MB image, although I've
not seen a BIOS yet that didn't like a 2.88 MB image on a CD.

-- 
Ciao,
Pascal
