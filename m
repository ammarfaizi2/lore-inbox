Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSFYN4O>; Tue, 25 Jun 2002 09:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSFYN4N>; Tue, 25 Jun 2002 09:56:13 -0400
Received: from enchanter.real-time.com ([208.20.202.11]:60676 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S315483AbSFYN4M>; Tue, 25 Jun 2002 09:56:12 -0400
Date: Tue, 25 Jun 2002 08:56:14 -0500
From: Carl Wilhelm Soderstrom <chrome@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: linux on wyse winterm 3730LE
Message-ID: <20020625085614.M6959@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to load linux on a Wyse WT3730LE. Normally these things run Wince
or Embedded NT, but I'm trying to subvert it to run linux.

I'm using a linux box running ISC DHCPd and atftpd as the DHCP and TFTP
servers. After making the servers listen on the correct ports (10067 and
10069), and tagging the boot images with mknbi-linux, I can get the winterm
to download the boot images. However, it halts after saying 
'Upload Successful	[4002](01)'
and does nothing more.

these boxes supposedly have a NatSemi Geode processor; possibly 166MHz. I
can't remove the mobo from it's cage (the processor, video and ethernet
chips are on the underside), so I can't see for certain what those chips
are.

since as far as I know, a NatSemi Geode processor is x86 compatible, I was
thinking that it should be able to boot fine. (or at least start booting
linux, enought to kernel panic).

I also tried loading Etherboot (etherboot.sourceforge.net) images, and those
wouldn't operate either.

We also tried putting a linux kernel on the CF disk that came with it, and
found that we couldn't read the Wyse CF disk with a USB CF reader. Nor would
the winterm boot with an ordinary CF disk that had a linux kernel on it.

are these winterms not fully x86 compatible? is there something else that
must be done to boot linux on them? 

thank you,
Carl Soderstrom.
-- 
Network Engineer
Real-Time Enterprises
www.real-time.com
