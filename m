Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132837AbRDIUSB>; Mon, 9 Apr 2001 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRDIURw>; Mon, 9 Apr 2001 16:17:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132837AbRDIURe>; Mon, 9 Apr 2001 16:17:34 -0400
Subject: Re: aic7xxx and 2.4.3 failures
To: jim@federated.com (Jim Studt)
Date: Mon, 9 Apr 2001 21:19:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104091933.OAA05314@core.federated.com> from "Jim Studt" at Apr 09, 2001 02:33:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mi85-0002pu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A typical startup with 6.1.9 proceeds like this...  (6.1.10 hangs silently
> after emitting the scsi0 and scsi1 adapter summaries, maybe it is
> going through the same gyrations silently.) 
> 

Try saying N to the AIC7xxx driver and Y to AIC7XXX_OLD and see if that works.
This is important both because it might solve your problem for now but also
because if the old driver works we can be fairly sure the bug is in the 
new adaptec driver and not elsewhere and triggered on it

