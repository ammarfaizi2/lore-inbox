Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVHXDPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVHXDPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 23:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVHXDPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 23:15:30 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:13048 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1750941AbVHXDPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 23:15:30 -0400
Date: Tue, 23 Aug 2005 23:15:27 -0400 (EDT)
Message-Id: <200508240315.j7O3FRGe003071@ms-smtp-02.rdc-nyc.rr.com>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-URL: mailto:linux-kernel@vger.kernel.org
X-Mailer: Lynx, Version 2.8.6dev.13a
From: robotti@godmail.com
Subject: Initramfs and TMPFS!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   >I have a path for initramfs to use tmpfs. It's sorta hacky so I never
   >submitted it and solves a niche problem for embedded people.
   >Ultimately we might one day still want to change how we initialize the
   >early userspace (Al suggesting a reasomably nice way to move the
   >decompressor(s) to userspace for example) so I don't feel there is a
   >compelling reason to do more than cleanups in this area right now.

I found that there is a patch that does what I suggested, but it needs
to be updated to support the latest 2.6 kernel.

   http://lwn.net/Articles/14394/

Dave Cinege's patch.
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/initrd_dynamic-2.5.45.diff.gz

If you point me to your patch, I'll try it.
