Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSJUHM7>; Mon, 21 Oct 2002 03:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbSJUHM7>; Mon, 21 Oct 2002 03:12:59 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:35556 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261165AbSJUHM6>; Mon, 21 Oct 2002 03:12:58 -0400
Message-ID: <3DB3AABC.2040208@snapgear.com>
Date: Mon, 21 Oct 2002 17:20:28 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Rob Landley <landley@trommello.org>
Subject: Re:  Rob Landley <landley@trommello.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Rob Landley wrote:
 > If your patch isn't on the list, speak out now.  Better yet, post a 
URL to the
 > latest version.  It's "show me the code" time.  (Yes, Hans Reiser, 
this means
 > you. :)  There are still 7 days till the end of Linus's cruise, but 
that's
 > not much time to get guinea pigs to publicly pipe up with a hearty 
"AOL!" of
 > support for your work...

Here's another feature I would like to see go in: MMU-less procesor support.

Latest patches for the memory management changes are at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-mm.patch.gz

The core of this stuff has been around for years (earliest in 2.0.33),
with a _lot_ of users (easily > 50000). And specifically these patches
have been tracking every 2.5 release pretty much since it started.

The other important peice with this is the FLAT format exe loader
(binfmt_flat), patch at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-binflat.patch.gz

To make this truely useful though you also need some new archiecture
support. Up to date patches for 2 of these are at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-m68knommu.patch.gz
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-v850.patch.gz

These support the non-VM 68k processors (683XXX and ColdFire), and the
NEC v850 family. [We have many more (ARM, SPARC, i960, etc) but they are
not 2.5 ready yet].

Also some drivers to go along with this, but I won't bother listing
them here. See my other emails on the list for those patches...

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

