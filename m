Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281109AbRKDSmP>; Sun, 4 Nov 2001 13:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKDSiN>; Sun, 4 Nov 2001 13:38:13 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:35235 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S281134AbRKDSha>;
	Sun, 4 Nov 2001 13:37:30 -0500
Date: Sun, 04 Nov 2001 18:37:24 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Linux 2.4.13-ac7; minor IDE wierdness while failing to run
 VMWare
Message-ID: <617912685.1004899044@[195.224.237.69]>
In-Reply-To: <20011103185216.A24888@lightning.swansea.linux.org.uk>
In-Reply-To: <20011103185216.A24888@lightning.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> *	Handle with care. This has the IDE driver update

I've had one bit of wierdness, twice so far, which you
might be interested in.

I installed VMWare Beta 1455 (available from their site) which
is totally borked on my system (i.e. won't even load lilo
from the native partition which is IDE). Didn't kernel
oops or anything. Nor did it get to touching the linux
partion beyond attempting (and failing) to load lilo.

I shut down the machine (properly), did all the syncing disk
stuff etc. etc.. On reboot, it thought my /dev/hda partition
had not been shut down cleanly.

It's almost as if the final sync() didn't take effect. Wouldn't
worry had I not seen this twice, together with Alan's warning :-)

.config file at
  http://www.alex.org.uk/T23/dot-config-2.4.13-ac7

[OT: And if anyone has any clue how to make VMWare behave,
     please mail me - 1455 and 1453 seem totally borked here,
     1433 at least tried to boot something - details on request ]

--
Alex Bligh
