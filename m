Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130707AbRBMICa>; Tue, 13 Feb 2001 03:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbRBMICU>; Tue, 13 Feb 2001 03:02:20 -0500
Received: from [213.97.45.174] ([213.97.45.174]:53742 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S130707AbRBMICC>;
	Tue, 13 Feb 2001 03:02:02 -0500
Date: Tue, 13 Feb 2001 09:01:53 +0100 (CET)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Stig Brautaset <stigbrau@online.no>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia-issues with 2.2.18 & 2.4.0
In-Reply-To: <87k86vzb76.fsf@arwen.wmin.ac.uk>
Message-ID: <Pine.LNX.4.33.0102130859050.1612-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2001, Stig Brautaset wrote:

> I have a Xircom Combo CardBus (32 bit) 10/100 Ethernet Card + 56k
> Modem (didn't try the modem part) that I have not been able to run
> under 2.2.18 or 2.4.0. The weird part is that everything seems to load
> fine, and I am able to configure the card with an ip-address and
> everything. Only sad part is that I can not reach out to the world. I
> just get connection time-outs when trying to acces the 'net.

> BTW, The driver used by the card is tulip_cb, and the machine it runs
> on is a Dell Latitude CPx H500GT.

I use:
alias eth0 xircom_tulip_cb

and when this happens -90% if times when I boot and 100% of time when I
awake after a sleep- I just do the following:

ifconfig eth0 -promisc

and it works again.

Pau

