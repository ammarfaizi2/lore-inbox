Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbREZW6z>; Sat, 26 May 2001 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbREZW6p>; Sat, 26 May 2001 18:58:45 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261866AbREZW6b>;
	Sat, 26 May 2001 18:58:31 -0400
Date: Sun, 27 May 2001 01:00:24 +0300 (EEST)
From: Doru Petrescu <pdoru@kappa.ro>
Reply-To: pdoru@kappa.ro
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to open an initial console (on SMP machine)
In-Reply-To: <Pine.LNX.4.21.0105261858380.11060-100000@bigD.kappa.ro>
Message-ID: <Pine.LNX.4.21.0105270053090.11502-100000@bigD.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:(

ok, so after diging few hours into the kernel it seems that the vgacon.c
fails to detect/initialize the VGA card. also it seems that it is not
listed in the /proc/pci ... so I guess there is a bit of a hardware
problem ... probably the card moved in its slot and now it is not working
properly.

I will investigate and let you guys know if this is a 'hardware' problem ...
and is just a concidence that it started when I upgraded to 2.4.5-preX

anyway, I think that the VGA console driver should emit an WARNING that 
"No VGA card detected => VGA console disabled"

'cause if I select VGA text console in the kernel config, I am
probably expecting to have one. and the rest that use mathines with no
video card, can just unselect the VGA console option if they don't like
seeing the warning.


unfortnatly the machine is in a remote location, and i can't go and fix
the video card at this hour (01:00 am) ... :(



Best regards,
Doru Petrescu

