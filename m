Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSCOK4n>; Fri, 15 Mar 2002 05:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSCOK4e>; Fri, 15 Mar 2002 05:56:34 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:35076
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S289606AbSCOK4X>; Fri, 15 Mar 2002 05:56:23 -0500
Date: Fri, 15 Mar 2002 11:56:17 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: David Forrest <drf5n@mug.sys.virginia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K7S5A SIS735 ext2fs corruption
Message-ID: <20020315115617.A31027@bouton.inet6-interne.fr>
Mail-Followup-To: David Forrest <drf5n@mug.sys.virginia.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203142014160.7770-100000@mug.sys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203142014160.7770-100000@mug.sys.virginia.edu>; from drf5n@mug.sys.virginia.edu on Thu, Mar 14, 2002 at 08:38:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:38:36PM -0500, David Forrest wrote:
> I know this has been on the list before, but I wanted to whine a bit, and
> collect what I've seen because I havent seen it resolved
> 
> lkml: 2001-12-30 UMOUNTING in 2.4.17 / Ext2 Partitions destroyed (3x)
> lkml: 2001-10-25 Repeatable File Corruption (ECS K7S5A w/SIS735)
> 
> http://www.geocities.com/mrathlon2000/   and
> http://pub65.ezboard.com/fk7s5amotherboardforumfrm10.showMessage?topicID=2.topic
> suggests a couple hardware fixes, and blames corruptions on high speeds
> and a bad resistor choice.
> 
> My ECS k7s5a with the SIS735 Athalon 1.4 chipset has corrupted a couple of
> my disks
> 

Try latest ac kernel or my patches
at http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html
(stock kernel doesn't have correct timings yet).

Look at your board revision too. I had a k7s5al (k7s5a + lan) rev 4+ which did corrupt
data. The new one I own is a rev 7 and doesn't exhibit a single problem.

You can find the revision black printed on a white sticker near the last PCI slot
(the one farest from the AGP one).

If you still have data corruption with latest ac kernel or with my
latest patch applied you definitely have a faulty board.

LB.
