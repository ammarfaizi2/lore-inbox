Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312978AbSDBWlN>; Tue, 2 Apr 2002 17:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDBWlE>; Tue, 2 Apr 2002 17:41:04 -0500
Received: from web13107.mail.yahoo.com ([216.136.174.152]:38408 "HELO
	web13107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312978AbSDBWky>; Tue, 2 Apr 2002 17:40:54 -0500
Message-ID: <20020402224053.14575.qmail@web13107.mail.yahoo.com>
Date: Tue, 2 Apr 2002 23:40:53 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Screen corruption in 2.4.18
To: root@chaos.analogic.com
Cc: VANDROVE@vc.cvut.cz, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020402172447.7371A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Richard B. Johnson" <root@chaos.analogic.com>
wrote: > On Tue, 2 Apr 2002, Chris Rankin wrote:
> [SNIPPED...]
> 
> > 
> > A few other things:
> > - since I have about 1.25 GB of RAM, I have
> enabled a 256 MB AGP aperture.
> 
> What? 'since amount of RAM' has nothing to do with
> AGP aperature. The
> aperature should be the same as the amount of AGP
> shared RAM used for
> the screen-card on-board graphics. This is normally
> set by the BIOS but
> can be reset if the BIOS doesn't 'understand' your
> screen card.
> 
> So, unless you have 256 MB on your screen board,
> typically 32 MB for
> high-resolution true-color boards, you will be
> disabling PCI hardware
> hand-shaking for a lot of addresses above your
> screen board. This
> can make DRAM-controler, controlled RAM accesses
> interfere.

I set the AGP aperture based upon the following
information:

"The AGP aperture is an area of system RAM reserved
for use by the AGP card for storing textures if it
needs to.  The RAM is available for use by the system
as normal if not used by the graphics card."
...
"It is generally advised to set the AGP aperture to
half the system RAM ."

Therefore, it seemed reasonable to maximise my AGP
aperture size for all and any conceivable textures (I
have system RAM to spare), with no harm done.
Admittedly, 256 MB does seem excessive, but anyway ...
;-).

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
