Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263567AbRFGWmk>; Thu, 7 Jun 2001 18:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbRFGWma>; Thu, 7 Jun 2001 18:42:30 -0400
Received: from jalon.able.es ([212.97.163.2]:2440 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S263567AbRFGWmR>;
	Thu, 7 Jun 2001 18:42:17 -0400
Date: Fri, 8 Jun 2001 00:41:41 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Khalid Aziz <khalid@fc.hp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
Message-ID: <20010608004141.A1534@werewolf.able.es>
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FD67D.8DFDAE58@pcsystems.de> <3B1FDB64.1AB850CF@fc.hp.com> <3B1FDD9F.49E55D9B@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B1FDD9F.49E55D9B@pcsystems.de>; from nicos@pcsystems.de on Thu, Jun 07, 2001 at 22:01:35 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07 Nico Schottelius wrote:
> >
> > Based upon the lspci output you posted earlier, aic7880 has a single
> > SCSI bus.
> 
> Oh. That could really be a problem.. I though having two different
> connectors on the board would make two different buses..
> I must have been wrong.
> 
> > So you must mean two internal connectors. Both of your devices
> > (HD and Tape) do show up on the same bus during scan. Since you have
> > connected devices to both connectors on the card, you must terminate
> > both devices.
> 
> Okay, so far I understood.
> 

And, AFAIK, the controller stands in the bus between the disk and the tape,
so you should terminate both AND disable the controller internal terminator
or leave it in AUTO mode.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
