Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOCw2>; Tue, 14 Nov 2000 21:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKOCwT>; Tue, 14 Nov 2000 21:52:19 -0500
Received: from Host4.modempool1.milfordcable.net ([206.72.42.4]:3076 "HELO
	windeath.2y.net") by vger.kernel.org with SMTP id <S129047AbQKOCwI>;
	Tue, 14 Nov 2000 21:52:08 -0500
Message-ID: <3A11F441.327F14B4@windeath.2y.net>
Date: Tue, 14 Nov 2000 20:26:09 -0600
From: James M <dart@windeath.2y.net>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gert Wollny <wollny@cns.mpg.de>
Cc: linux-kernel@vger.kernel.org, twaugh@redhat.com
Subject: Re: Parport/IMM/Zip Oops Revisited -- Winbond
In-Reply-To: <Pine.LNX.4.10.10011150012390.684-100000@bolide.beigert.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Wollny wrote:
> 
> On Tue, 14 Nov 2000, James M wrote:
> >    Was just trying to find out why I can mount in 11pre1 and 11pre2 when
> > Gert can't mount at all, so I removed my VFAT factory formatted zipdisk
> > and put in an Ext2 formatted one.....**BOOM**
> 

The configure help for the Winbond SuperIO states:

"Saying Y here enables some probes for Super-IO chipsets in order to
find out things like base addresses, IRQ lines and DMA channels.  It
is safe to say N."

Enabling this allows me to mount both VFAT and EXT2 in 11pre3, it
appears it should no longer be marked "Experimental" or "Safe to say No"
in the case of Zipdrives at least.

Dunno what time it is over there but could you give this a try when you
get a chance? My port is still misdetected but at least I didn't have to
fsck this time...;=)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
