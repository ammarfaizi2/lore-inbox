Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272071AbTHFV46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272355AbTHFV46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:56:58 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:30883 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272071AbTHFV45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:56:57 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Albert E. Whale, CISSP" <aewhale@ABS-CompTech.com>
Date: Wed, 6 Aug 2003 23:56:27 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux Kernel Question - from non-subscriber
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <965253710F1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 03 at 16:59, Albert E. Whale, CISSP wrote:
> I have been searching for a Howto (which is not outdated or Broken), on
> how to mount a Netware 3.x or 4.x Filesystem on Linux.  I have 2.4.21
> operating on Linux Mandrake 9.1.  I have installed ncpfs-2.2.2 and
> desire to mount this filesystem to recover lost information for a
> Non-Profit Organization.  I will post a HOWTO to the Slueth-kit List for
> future reference.

nwfs can be used for this. ncpfs is for connecting to the live server,
and you apparently do not have live server, if I understand it correctly.
 
> As the Vender list is non-technical (more of a SCO Flamewar) nature
> currently, and I am in need of this procedure to mount the Drive (I have
> a 60 GB Disk on a USB Port with the Ghost Image installed on the drive -
> full Inode replica).

What's wrong with installing NetWare and accessing data through netware? 
I think that it is simplest way to go. 

If netware cannot mount the disk, then nwfs will not mount
it too. Besides that nwfs is unmaintained - or at least I do not know
where updated code lives.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

