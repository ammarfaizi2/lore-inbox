Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTFVJAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTFVJAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:00:33 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:34806 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S264201AbTFVJA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:00:29 -0400
Message-ID: <3EF57376.8106D1DD@eyal.emu.id.au>
Date: Sun, 22 Jun 2003 19:14:30 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-rc8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21: USB Mass Storage data integrity not assured?
References: <3EF556D0.5060900@Synopsys.COM> <20030622011948.E10803@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And IDE will be assured under similar actions? And SCSI?
And any removable media yanked without unmounting?

Either the message is useless or there is a real higer
risk with USB that with other buses - and I would like to
know what it is too.

Matthew Dharm wrote:
> 
> That warning means that if you yank the device at a bad time, you could get
> screwed.
> 
> Matt
> 
> On Sun, Jun 22, 2003 at 09:12:16AM +0200, Harald Dunkel wrote:
> > Hi folks,
> >
> > This morning I tried to attach an 2.5" HD via USB2.0 to my Linux box.
> > I got a message
> >
> >       WARNING: USB Mass Storage data integrity not assured
> >
> > in kern.log, followed by billions of IO errors during mkfs.
> >
> >
> > Well, I need a mass storage whose integrity _is_ assured. Is there
> > any hope that ehci and usb-storage get improved for a 2.4.x kernel?
> > Any patches I could try?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
