Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280771AbRKOIAq>; Thu, 15 Nov 2001 03:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRKOIAf>; Thu, 15 Nov 2001 03:00:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:57340 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280771AbRKOIAX>;
	Thu, 15 Nov 2001 03:00:23 -0500
Date: Thu, 15 Nov 2001 03:00:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] races in access to pci_devices
In-Reply-To: <3BF37508.6EA78A85@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0111150257590.2244-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Nov 2001, Jeff Garzik wrote:

> alas, yes, that's been there since time began, and since the window was
> so minimal nobody cared enough to do anything about it.  Even on the
> larger hotplug PCI servers that Greg KH mentioned, the pci list really
> isn't traversed much, much less updated.

while true; do cat </proc/bus/pci/devices >/dev/null; done - notice that it's
world-readable (ditto for /proc/pci).

