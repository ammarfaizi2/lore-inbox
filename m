Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUAVPX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAVPX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:23:26 -0500
Received: from ppp-82-135-4-160.mnet-online.de ([82.135.4.160]:5504 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S266040AbUAVPVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:21:39 -0500
Date: Thu, 22 Jan 2004 16:21:37 +0100
From: Julien Oster <lkml-3141@mc.frodoid.org>
To: linux-kernel@vger.kernel.org
Subject: parhelia doesn't work anymore with 2.6.1
Message-ID: <20040122152137.GA1138@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know the Matrox Parhelia kernel driver ist partly a binary only
driver, but I am not explicitly asking for support on that driver.

My question is: what has changed in AGP code or similar between 2.4.24
and 2.6.1 that can make my Parhelia unusable?

With 2.6.1, I can't use X anymore. Both of my screens seem to be cloned
upon each other (looks really freaky). Additionally, if I exit X, the
system locks up hard. It seems that something is wrong with the memory
mapping and that somehow the memory for the second screen gets mapped to
the same area as the memory for the first screen.

So, what could be the kernel change that affects the memory mapping of
an AGP graphics card - and what would one do to fix that? I'll do it
myself, hoping that it's in the open source portion of the driver (it
most certainly is)

Any ideas?

Regards,
Julien

