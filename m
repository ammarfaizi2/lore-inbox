Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSENStz>; Tue, 14 May 2002 14:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315989AbSENStz>; Tue, 14 May 2002 14:49:55 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:45758 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S315988AbSENStx>;
	Tue, 14 May 2002 14:49:53 -0400
Date: Tue, 14 May 2002 20:49:51 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: IDE & Geometry & Portability of disks between controllers
Message-ID: <20020514184950.GA17678@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I moved an IDE disk to another machine and some weird things
happened.

LILO booted from RAID and both halves of the RAID mirror were transplanted to
the new machine. 

1) When booting 'LIL' appeared and then nothing happened for a few seconds,
   after which the final 'O' appeared, and the system would boot normally.

2) Booting worked but writing to the mirror quickly lead to very bogus
   'attempt to access beyond end of device' errors.

Not, this together leads me to the question - should I expect to be able to
move an IDE disk from one machine to another and have it function correctly,
always? 

Thanks for your time.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
