Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbRBBUgk>; Fri, 2 Feb 2001 15:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRBBUga>; Fri, 2 Feb 2001 15:36:30 -0500
Received: from h0000f8512160.ne.mediaone.net ([24.128.252.23]:24820 "EHLO
	dragon.universe") by vger.kernel.org with ESMTP id <S129178AbRBBUgU>;
	Fri, 2 Feb 2001 15:36:20 -0500
Date: Fri, 2 Feb 2001 15:36:18 -0500
From: newsreader@mediaone.net
To: linux-kernel@vger.kernel.org
Subject: did 2.4 messed up lilo?
Message-ID: <20010202153618.A653@dragon.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure whether this problem is related
to 2.4 kernel.

I've installed kernels 2.4.0-prex to 2.4.1 on
the following machines.  All are now running 2.4.1.
Judging from my past experience posting here I'm giving much
information 

- compaq prolinea p-90 de4x5 driver 1 gig quantum drive cmd 640 controller
- dell optiplex p-133 hp-pcplus driver 8 gig seagate cmd 640 controller
- ibm p-133 de4x5 driver maxtor 4 gig

All partitions are reiserfs.  except for dell box linux is
the only system and root is on /dev/hda1.  dell's root is on
/dev/hda7 with /dev/hda1 occupied by the unmentionable.

Soon after I've installed 2.4.xx lilo stopped working
properly.  Unfortunately I'm not sure whether it
started with as soon as any 2.4 installed or on subsequent
installation.

What happens is the lilo does not give you any prompt
any more.  My /etc/lilo.conf, of course, have proper
timeout parameter which were working before with 2.2.18.

On compaq it does not even boot at all from hard drive.
I'm using a floopy to boot and run that box.  Others
just boot right into the default specified in /etc/lilo.conf

I would not be complaining if it weren't for the fact
that lilo does not obey kernel parameters any more. On
ibm box I need to append="hdc=ide-scsi" to use
my cd-rw drive.  The system boots with the right
kernel but I cannot use cd-rw because it apparently 
is not looking at the kernel parameters.

I also am no good at installing lilo on a floppy.

I apologize in advance if this problem is not 2.4 related.

FYI I've also installed 2.4 on celeron 566 without
this problem.  I'm just not running 2.4 on this one
just because I cannot make the graphics card
operate under 2.4

Thanks in advance






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
