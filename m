Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285391AbRLNPP4>; Fri, 14 Dec 2001 10:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285392AbRLNPPp>; Fri, 14 Dec 2001 10:15:45 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:14342 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S285391AbRLNPPi>; Fri, 14 Dec 2001 10:15:38 -0500
Date: Fri, 14 Dec 2001 15:15:18 +0000
From: Bob Dunlop <bob.dunlop@xyzzy.org.uk>
To: Daniela Squassoni <daniela@cyclades.com>
Cc: Krzysztof Halasa <khc@intrepid.pm.waw.pl>,
        Fran?ois Romieu <romieu@cogenit.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: dscc4 and new Generic HDLC Layer
Message-ID: <20011214151518.B30306@xyzzy.org.uk>
In-Reply-To: <3C19CA22.E604CB32@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C19CA22.E604CB32@cyclades.com>; from daniela@cyclades.com on Fri, Dec 14, 2001 at 01:58:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Dec 14,  Daniela Squassoni wrote:
> Hello all,
> 
> This is the last patch from Krzystof Halasa for the Generic HDLC layer
> plus some changes to adapt dscc4.c (maintained by François Romieu) to
> it.

I'm confused.  How was the patch generated ?   How should I apply it ?

The patch repeats some of Krzystofs changes so I can't apply it over the
top of his patch but at the same time it doesn't include the changes for
FarSite, SBE Inc or you own Cyclades cards.  Better to have a patch that
brings all the drivers up to spec in one hit surely.


Probably too late to get API changes into 2.4.x, but we should get the
generic HDLC layer into 2.5.x ASAP IMHO.  Then you might be able to argue
for a backport into 2.4.x in the future.


> I am waiting for the inclusion of these changes in the kernel for months
> to submmit the PC300 driver, and this delay is causing me troubles,
> customers complainings, etc.

Tell me about it :-)  FarSite are having to maintain an extra set of patches
for customers who need the functionality of the generic layer.


ps. I'm no longer working for FarSite the lure of embeded Linux and video
    was too much :-) so these comments are mine not theirs.

-- 
        Bob Dunlop
