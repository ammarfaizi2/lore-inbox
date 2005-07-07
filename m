Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVGGRSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGGRSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGGRSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:18:10 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:55257
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261444AbVGGRQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:16:33 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Clemens Koller'" <clemens.koller@anagramm.de>,
       "'Jens Axboe'" <axboe@suse.de>
Cc: "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Alejandro Bonilla'" <abonilla@linuxwireless.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>, <hdaps-devel@lists.sourceforge.net>,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: RE: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Date: Thu, 7 Jul 2005 11:15:50 -0600
Message-ID: <002401c58317$865ee6a0$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42CD600C.2000105@anagramm.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello,
>
> Just for the records....
> -----
> root@ecam:~$ ./headpark /dev/hda
> head not parked 4c
> -----
>
> HDD is a desktop Maxtor Diamond MaxPlus 9 120GB
> on a Promise Ultra133 TX2 IDE Controller.
>
> Well, sure, it's not a notebook HDD, but maybe it's possible
> to give headpark a more generic way to get the heads parked?
>
> Are the commands different per HDD model / manufacturer?
> Then we might need some information to send the proper
> commands to the different types?!
> And if there is no headpark command, might it be valuable to send
> the HDD a shutdown instead?
>
> PS:
> I'm working on an embedded PowerPC (MPC8540) system which
> will be turned into a high-resolution portable camera in
> the future (with acceleration sensors for the right image
> orientation). Therefore it will likely be another candidate
> for a Drop'n'Park or Drop'n'Stop (tm) feature as are planning
> to put a 2.5" notebook HDD into the cam, too.
>
> Greets,
>
> Clemens Koller

Clemens,

	Thanks for bringing this up. We were actually in a conversation about this
subject in IRC a couple of minutes ago, and this actually came up. It would
be a good idea to kick this little script into the kernel so that people
that develop new accelerometers will be able to just make the call from the
script already in the kernel.

	How do we go by making this script maybe more broad, or simple so that it
can be implemented on more devices?

We could either leave this for only some hard drives, like camera's and
notebooks and use hdparm for other systems, or then use this script for all
HD's.

What could we do?

.Alejandro

