Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132444AbQLVXcH>; Fri, 22 Dec 2000 18:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132486AbQLVXb5>; Fri, 22 Dec 2000 18:31:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:57350 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132444AbQLVXbs>; Fri, 22 Dec 2000 18:31:48 -0500
Date: Fri, 22 Dec 2000 16:56:37 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222165637.B2437@vger.timpanogas.org>
In-Reply-To: <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org> <20001222113530.A14479@vger.timpanogas.org> <20001222202137.A27844@gruyere.muc.suse.de> <20001222132541.A1555@vger.timpanogas.org> <20001222205103.A9441@polyware.nl> <20001222145450.B2025@vger.timpanogas.org> <20001222223943.E25239@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222223943.E25239@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Fri, Dec 22, 2000 at 10:39:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 10:39:43PM +0100, Erik Mouw wrote:
> On Fri, Dec 22, 2000 at 02:54:50PM -0700, Jeff V. Merkey wrote:
> > Having a 1 Gigabyte per second fat pipe that runs over a prallel bus 
> > fabric with a standard PCI card that costs @ $ 500 and can run LVS 
> > and TUX at high speeds would be for the common good, particularly since
> > NT and W2K both have implementations of Dolphin SCI that allow them 
> > to exploit this hardware.  
> 
> I'm just wondering how you are going to do 1 Gbyte per second when you
> still have to get the data through a PCI bus to that card. In theory,
> standard PCI can do 133 Mbyte/s, but only when you're very lucky to be
> able to burst large chunks of data. OK, 64 bit PCI at 66 MHz should
> quadruple the throughput, but that's still not enough for 1 Gbyte/s.

THe fabric supports this data rate.  PCI cards are limited to @ 130MB, 
but multiple nodes all running at the same time could generate this much
traffic.

Jeff

> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
