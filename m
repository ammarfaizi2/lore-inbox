Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263924AbRFNTNU>; Thu, 14 Jun 2001 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbRFNTNJ>; Thu, 14 Jun 2001 15:13:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61362 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263961AbRFNTM4>;
	Thu, 14 Jun 2001 15:12:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.3254.105970.424506@pizda.ninka.net>
Date: Thu, 14 Jun 2001 12:12:54 -0700 (PDT)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), tom_gall@vnet.ibm.com (Tom Gall),
        linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
In-Reply-To: <15145.1739.395626.842663@pizda.ninka.net>
	<200106141904.f5EJ4AD413350@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Albert D. Cahalan writes:
 > >>    /proc/bus/PCI/0/0/3/0/config   config space
 > >
 > > Which breaks xfree86 instantly.  This fix is unacceptable.
 > 
 > Nope. Keep /proc/bus/pci until Linux 3.14 if you like.
 > The above is /proc/bus/PCI. That's "PCI", not "pci".
 > We still have /proc/pci after all.

Oh I see.

Well, xfree86 and other programs aren't going to look there, so
something had to be done about the existing /proc/bus/pci/* hierarchy.

To be honest, xfree86 needs the controller information not for the
sake of device probing, it needs it to detect resource conflicts.

Anyways, I agree with your change, sure.

 > Did you somehow miss when Linus scolded you a few weeks ago?

You mean specifically what?

Later,
David S. Miller
davem@redhat.com

