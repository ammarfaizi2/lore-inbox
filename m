Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313093AbSDMMDC>; Sat, 13 Apr 2002 08:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDMMDB>; Sat, 13 Apr 2002 08:03:01 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:896 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S313093AbSDMMDB>;
	Sat, 13 Apr 2002 08:03:01 -0400
Date: Sat, 13 Apr 2002 14:02:46 +0200
From: Stanislav Meduna <stano@meduna.org>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-users@lists.sourceforge.net
Subject: Re: uhci locks up in 2.4.19-pre6
Message-ID: <20020413140246.A1701@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

trying to load a uhci module from 2.4.19-pre6 at boot locks my computer.

In 2.4.18 I noticed that the USB printing stopped to work
(see the thread "USB printing via ptal broke between 2.4.17 and .18"
started on 29 Mar). I the tested 2.4.19-pre5 and loading the uhci
module locked the machine. In -pre6 the behaviour is the same.

Can I switch some debug mode on to help you seeing where the thing
locks?

This is on the Abit BP6 motherboard (Celeron SMP box). I see that
there are quite a few changes in the uhci area - please, don't
make final 2.4.19 until these issues are resolved.

Using usb-uhci is not an option for me, as it is causing lockups
when printing to a USB printer (and ever did so). uhci was OK
in this regard up to 2.4.17.

Regards
-- 
                                     Stano

