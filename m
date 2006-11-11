Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946813AbWKKAQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946813AbWKKAQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946859AbWKKAQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:16:33 -0500
Received: from jp.dhs.org ([213.84.189.153]:27403 "EHLO debian.jp.dhs.org")
	by vger.kernel.org with ESMTP id S1946813AbWKKAQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:16:32 -0500
From: Jan Pieter <pptp@jp.dhs.org>
Organization: SIP_SPOOF, Inc.
To: linux-kernel@vger.kernel.org
Subject: The return of the ITeX PCI ADSL card for 2.6 kernels
Date: Sat, 11 Nov 2006 01:16:29 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110116.29320.pptp@jp.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ITeX stopped support for their PCI ADSL Apollo3 chipset because
they gone bankrupt. The latest Linux drivers for their chipset are
for kernel 2.4.15. They are binary-only.

I made a patch and a modified binary that allows you to use the
ITeX card with Linux 2.6.15 kernels. It has only been tested with
PPPoATM. It uses a modified binary that was originaly build by
ITeX for kernel 2.4.15.  Some 2.6.15 kernel structures were
modified for compatibility with 2.4.15, but no functionality has
been changed in the 2.6.15 kernel. I use this for more than a
month now without problems. It works with vanilla, Debian and
Ubuntu kernel sources. See http://jp.dhs.org/~itex/2.6/ .

There is also a patch for vanilla 2.4.31 and 2.4.32 kernel sources
at http://jp.dhs.org/~itex/patch-2.4.31-oldatm.bz2 . For Debian's
2.4.27 source at http://jp.dhs.org/~itex/patch-2.4.27-oldatm.bz2


Jan Pieter. 
