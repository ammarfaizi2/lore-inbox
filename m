Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTDNBpN (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 21:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDNBpN (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 21:45:13 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:41321 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S262665AbTDNBpM (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 21:45:12 -0400
Subject: Aironet Driver Issues in 2.5.x Kernels
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1050285197.3439.25.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 13 Apr 2003 21:56:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been trying various versions of the 2.5 kernel for that last few
weeks on my laptop (a Dell C810, 1.13Mhz PIII, 512MB).  The system has
always proven to be difficult to get running because of needing the
Nvidia binary drivers or the VMware network drivers.  However, with
recent 2.5.6x kernels the system has become very stable, even with these
extra commercial drivers.

However, I do have one last problem, specifically the driver for the
Aironet driver.  I have a Aironet 350 PCMCIA card in this laptop, and I
can get the card to work, but only with the Cisco utilities.  If I try
to use the iwconfig wireless utilities my system locks hard.  Sometimes
it generates an oops, but unfortunately I have never been able to
capture it.

To make sure it was not related to PCMCIA I tried a 2.5.66 kernel on an
old AMD K6-2 with a PCI version of the 350 and it had the same exact
symptoms.  This system has no special modules (like VMware or the nvidia
drivers) so it should be a good test.

Is anyone else having similar problems?  Are there any patches that I
should try?  I'll work harder at try to actually capture one of the oops
reports (most of the time when I get them they have the binary drivers
installed so I'm not sure how valuable they are).

I can also hang the system using the Cisco utilities as well but I have
to work at it harder.

I'll be glad to help with any testing or provide as much information as
I can gather.

Later,
Tom




