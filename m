Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLHAsP>; Thu, 7 Dec 2000 19:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbQLHAsF>; Thu, 7 Dec 2000 19:48:05 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:12293 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129392AbQLHAr4>; Thu, 7 Dec 2000 19:47:56 -0500
Date: Fri, 8 Dec 2000 01:23:21 +0000
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: D-LINK DFE-530-TX
Message-ID: <20001208012321.A1732@colonel-panic.com>
Mail-Followup-To: pdh, "Mike A. Harris" <mharris@opensourceadvocate.org>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0012061942570.620-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0012061942570.620-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Wed, Dec 06, 2000 at 07:44:02PM -0500
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 07:44:02PM -0500, Mike A. Harris wrote:
> Which ethernet module works with this card?  2.2.17 kernel
> 

If the PCI device ID is 3065 then it's via-rhine, but not supported by the
driver in the kernel. Get updated via-rhine from Donald Becker's site
http://www.scyld.com/network.

Even the DFE-530-TX driver for NT downloaded from D-Link's site doesn't know
about this chip yet ... though changing the device ID in the .INF file seemed
to make it work ... shrug.

HTH

P.

-- 
+------------------------------------+
|            Peter Horton            |
+------------------------------------+
|    http://www.colonel-panic.com    |
|   http://www.berserk.demon.co.uk   |
|         Linux 2.4.0-test11         |
+------------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
