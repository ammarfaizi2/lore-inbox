Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTDPQvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDPQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:51:21 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:63698 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S264474AbTDPQvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:51:03 -0400
Date: Wed, 16 Apr 2003 19:01:27 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.21-pre7 + Intel 82801AA IDE + 80Gb Barracuda do not work
 well together
In-Reply-To: <1050508630.28727.134.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304161856410.4806-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr 2003, Alan Cox wrote:

> On Mer, 2003-04-16 at 17:15, Pau Aliagas wrote:
> > I'm having serious trouble dealing with:
> > * 80Gb Seagate Barracuda disc (Model Number ST380011A, Firmware Revision 3.04)
> > * on an Intel 82801AA IDE controller
> 
> Thats a known to work configuration, so that is strange. Is the drive
> known good and the driver/controller setup ok in "other OS" if you also
> run it ?

I've never tried it with borg OSes, but it used to work flawlessly with a 
40Gb HD. The problem arouse when installing this 80 Gb Barracuda.

> > (RH-8.0 updated kernels) unless I boot with ide=nodma.
> > With RH kernels it stalls reading the partition table.
> > With 2.4.21-pre7 I get and error of the dma.
> 
> Same error in both cases, just its recovered properly in the newer code.

Well, it did not recover as it disabled the hda disc saying something like 
"disc not operative" (take the concept not the words). 

So I rebooted with RH kernel and no dma. And that's what I have now. I'll 
be rebooting now removing all the extra parametres I used (idebus, ide0).

Pau

