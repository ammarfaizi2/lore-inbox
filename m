Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270781AbTG0N6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270783AbTG0N6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:58:44 -0400
Received: from lidskialf.net ([62.3.233.115]:11977 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S270781AbTG0N6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:58:44 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
Date: Sun, 27 Jul 2003 15:14:00 +0100
User-Agent: KMail/1.5.2
Cc: Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271301.41660.adq_dvb@lidskialf.net> <3F23DB4E.1000203@genebrew.com>
In-Reply-To: <3F23DB4E.1000203@genebrew.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271514.00724.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 July 2003 15:01, Rahul Karnik wrote:
> Andrew de Quincey wrote:
> > I've just dumped the mmapped IO space on mine. The MAC address shows up
> > at offset 0xa8, but the amd8111e driver is looking for it at 0x160
> > (there's just loads of 0x00 there).
>
> Hmmmm, with this info I am able to get amd8111e to read the correct MAC
> address, but the network connection does not seem to work anyway. How
> would we know if this is the right driver anyway?

Hmm, I have a suspicion it is not unfortunately, given the change in location 
of the MAC address. Or maybe nvidia have displaced the configuration 
registers by some amount?

