Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266219AbUGASoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266219AbUGASoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUGASoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:44:06 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:11970 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S266219AbUGASoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:44:00 -0400
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 01 Jul 2004 19:43:58 +0100
MIME-Version: 1.0
Subject: Re: 2.4.26: IDE drives become unavailable randomly
Cc: Andre Costa <costa@tecgraf.puc-rio.br>, ballen@gravity.phys.uwm.edu
Message-ID: <40E4697E.28752.15EB61B8@localhost>
In-reply-to: <20040701074933.722e40e4.costa@tecgraf.puc-rio.br>
References: <Pine.GSO.4.21.0407010446090.2056-100000@dirac.phys.uwm.edu>
X-mailer: Pegasus Mail for Windows (4.21b)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (please cc me on any replies, I am not subscribed to this list)
> 
> On Thu, 1 Jul 2004 04:48:30 -0500 (CDT)
> Bruce Allen <ballen@gravity.phys.uwm.edu> wrote:
> 
> > > I was getting this problem, and advice from smartmontools people was
> > > to clean out the box and reseat all cables etc.  Seemed to work for 
> > > me on the box at work with this DMA timeout issue - BTW, always 
> > > happened at idle, like 2:15am in the middle of the night etc.
> > > 
> > > Reference: 
> > > http://sourceforge.net/mailarchive/message.php?msg_id=8660397
> > > http://sourceforge.net/mailarchive/forum.php?thread_id=4908273&forum_i
> > > d=12495
> > 
> > An additional reference. See the entry that starts 'System freezes
> > under heavy load" in:
> > http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?view=markup
> > 
> > Cheers,
> > 	Bruce
> 
> Thks, folks, I wouldn't really suspect of bad cables/PSU, this was an
> eye-opener. I have just opened the box and reseated the 80-wire IDE
> cable to my hda device, and I will consider replacing it, just in case.
> The PSU is brand new, 450W -- although it could be bad quality, I will
> try to check this out.
> 
> BTW: Nick, I missed your msg because you didn't cc me. My hda also
> usually gets disconnected at early hours in the morning, as you pointed
> out. I arrived today to work and it had happened again =/ Last entry
> on/var/log/messages was around 1:30am, and it was about a NFS mount that
> had expired.
> 
> Best,
> 
> Andre

Hi Andre,

Sorry, I too am not subscribed to the list, and I read (and reply to) 
from:

http://marc.theaimsgroup.com/?l=linux-kernel

I totally overlooked CC'ing you.

Anyway, new IDE cable did fix the box at work for me.  Also I only 
used smartd AFTER the problem arose, not before, so it was not smartd 
that caused it.

Regards,

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
