Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267854AbRGRQFq>; Wed, 18 Jul 2001 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbRGRQFg>; Wed, 18 Jul 2001 12:05:36 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:3588 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S267854AbRGRQF3>; Wed, 18 Jul 2001 12:05:29 -0400
Date: Wed, 18 Jul 2001 18:04:03 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: David HM Spector <spector@zeitgeist.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI hiccup installing Lucent/Orinoco carbus PCI adapter
Message-ID: <20010718180403.I13239@arthur.ubicom.tudelft.nl>
In-Reply-To: <200107171706.f6HH63S05993@thx1138.ny.zeitgeist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107171706.f6HH63S05993@thx1138.ny.zeitgeist.com>; from spector@zeitgeist.com on Tue, Jul 17, 2001 at 01:06:03PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 01:06:03PM -0400, David HM Spector wrote:
> Hi,  included is a bug-report that seems to be a PCI oops that affects the 
> intallation of a Lucent PCI CardBus adapter.
> 
> [1.] One line summary of the problem:    
> 
>      PCI Drivers fail to allocate interrrupt for Lucent Cardbus bridge
> 
> [2.] Full description of the problem/report:
> 
> The 2.4.3 kernel recognizes the card but failts to allocate an
> interrupt for it.  This is the Lucent Oinoco PCI Carbus bridge product
> which is based on the TI1410 chip.  In talking with Dave Hinds about
> the problem, he looked at the enclose outbut and suggested that it
> looks like a kernel/PCI problem.

I posted a patch for this two weeks ago. It's fixed in linux-2.4.6.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
