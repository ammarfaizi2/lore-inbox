Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267727AbUBTIYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 03:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267729AbUBTIYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 03:24:22 -0500
Received: from 81-223-104-78.krugerstrasse.Xdsl-line.inode.at ([81.223.104.78]:47798
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S267727AbUBTIYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 03:24:21 -0500
Date: Fri, 20 Feb 2004 09:32:42 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-Scan Hangup ...
In-Reply-To: <20040220002047.GB16267@kroah.com>
Message-ID: <Pine.LNX.4.58.0402200920270.621@merlin.sk-tech.net>
References: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
 <20040220002047.GB16267@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There I have a Soekris bord with some weird PCI Handup while booting
> > Linux during PCI-Scan .
>
> Can you try to determine what is hanging in a non-modified 2.6.3 kernel?

The very last thing I see when booting ist:

   PCI: Probing PCI hardware (bus 0)

That's it.  But it seems to be a BIOS Proble - I just found out that the
Soekris-Home-Page states:

[...]

 The SC1100 has a bug where certain PCI config cycle conbinations can
 cause the processor to lock up. comBIOS version 1.21 or newer reprogram
 the chipset to fix the problem.

[...]

I'll try to upgrade my comBIOS this afternoon, and let you know if 2.6.x
boot's fine or not.

Regards
   Kianusch
