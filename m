Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293020AbSCJPfl>; Sun, 10 Mar 2002 10:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSCJPfc>; Sun, 10 Mar 2002 10:35:32 -0500
Received: from coruscant.franken.de ([193.174.159.226]:28643 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S293020AbSCJPf0>; Sun, 10 Mar 2002 10:35:26 -0500
Date: Sun, 10 Mar 2002 16:33:39 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: J Sloan <joe@tmsusa.com>, linux-kernel@vger.kernel.org,
        elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020310163339.H16784@sunbeam.de.gnumonks.org>
In-Reply-To: <E16bhwo-0007GZ-00@bronto.zrz.TU-Berlin.DE> <3C6D1E99.6070303@tmsusa.com> <20020227151218.78965262.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020227151218.78965262.skraw@ithnet.com>; from skraw@ithnet.com on Wed, Feb 27, 2002 at 03:12:18PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Pungenday, the 68th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 03:12:18PM +0100, Stephan von Krawczynski wrote:
> Hello,
> 
> quick additional question concerning this topic:
> If I were free to buy any Gigabit Adapter, what would be the known-to-work
> choice (including existence of a GPL driver, of course)?

>From my point of view, there is no 'perfect' choice.

You can buy bcm57xx based boards, where the chipset is nice but the driver
not really nice yet.

You can buy syskonnect sk98 boards, which definitely have a good chipset - 
but the driver doesn't support the tcp transmit zerocopy path yet.  I've
tried to put some pressure on SysKonnect about this - but they seem a bit
'slow'.

You can buy natsemi boards, which is a more-or-less crappy chipset, but 
there is a nice linux driver.

Summary:

Old acenic boards are still the best solution - but there are no longer
available for quite some time :(

> Regards,
> Stephan

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
