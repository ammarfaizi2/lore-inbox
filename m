Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVFHKqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVFHKqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVFHKqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:46:52 -0400
Received: from animx.eu.org ([216.98.75.249]:14267 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262158AbVFHKqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:46:40 -0400
Date: Wed, 8 Jun 2005 06:42:17 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kaweth fails to work on 2.6.12-rc[56]
Message-ID: <20050608104217.GA29490@animx.eu.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050608021140.GA28524@animx.eu.org> <20050608031101.GA28735@animx.eu.org> <200506080859.27857.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506080859.27857.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Mittwoch, 8. Juni 2005 05:11 schrieb Wakko Warner:
> > Wakko Warner wrote:
> > > Seems that it is unable to send packets however I can see packets coming in.
> > > I downgraded to 2.6.12-rc2 which works.
> > > 
> > > I have not tested rc3 or rc4 yet. ?I am preparing to try rc4.
> > 
> > Just finished testing.
> > rc2 works
> > rc3 works (fails on aic7xxx with my scsi hardware but rc5 works with my
> > ????????scsi hardware)
> > rc4 through rc6 do not work.
> 
> Hi,
> 
> have you tried recompiling with debug enabled?
> It does show the status codes in the interrupt handler.

I have not.  My keyboard and mouse (on a hub) are plugged in beside the
kaweth device so they would be on the same interrupt.

I did notice that the kaweth file itself hasn't changed, but something is
different between rc3 and rc4.

Someone else asked what host controllers.  I tried it on 2 systems.  The
device itself is USB1.  One machine running rc5 used Intel 440bx chipset. 
I'm not sure what controller it has but I was using the onboard USB which
uses uhci.  I don't have that machine anymore, it was temporary.  I'm
currently using this on an Intel E7505 chipset which uses both ehci and uhci
(loaded in that order)

I used the same configfile from rc2 when I compiled rc3 and rc4 (doing make
old config of course).  I'll see about testing this later on.  I don't have
time this morning to look at this.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
