Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbRFGTcF>; Thu, 7 Jun 2001 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbRFGTbz>; Thu, 7 Jun 2001 15:31:55 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:61422 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S263002AbRFGTbm>;
	Thu, 7 Jun 2001 15:31:42 -0400
Message-ID: <3B1FD67D.8DFDAE58@pcsystems.de>
Date: Thu, 07 Jun 2001 21:31:09 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

The problem is solved, if I disconnect the hp streamer
from the bus. I wonder why there is a problem.
The aic7880 has two busses:

ultra/ ultrawide.

The ibm hard disk is connected to the uw port and is terminated.
No other uw device is attached.

The hp streamer is also lonely on the ultra bus. I have
no documentation for that device, so I don't know
whether it is terminated nor if it is using parity.

Btw, can somebody explain what the parity bit does to me ?

Or does anybody have a hp c1536 streamer and can help me ?


Regards,

Nico

