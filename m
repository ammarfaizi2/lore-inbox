Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSFEH0A>; Wed, 5 Jun 2002 03:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFEHZ7>; Wed, 5 Jun 2002 03:25:59 -0400
Received: from grunt.ksu.ksu.edu ([129.130.12.17]:32992 "EHLO
	mailhub.cns.ksu.edu") by vger.kernel.org with ESMTP
	id <S313492AbSFEHZ7>; Wed, 5 Jun 2002 03:25:59 -0400
Date: Wed, 5 Jun 2002 02:25:59 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build error on 2.5.20 under unstable debian
Message-ID: <20020605022558.A2745@ksu.edu>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020604103633.A14326@ksu.edu> <20328.1023241142@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-School: Kansas State University
X-vi-or-emacs: vi
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, thanks for the nifty tool.  What docs are available so that I can
  learn the Magic of the Script?  :)

Anyhow, the output for 2.5.20:

linux-2.5.20:9$ ./reference_discarded.pl 
Finding objects, 784 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 102 conglomerate(s)
Scanning objects
Error: ./drivers/usb/host/uhci-hcd.o .rodata refers to 00000f98 R_386_32          .text.exit
Error: ./drivers/usb/host/built-in.o .rodata refers to 00000f98 R_386_32          .text.exit
Done

Looks like uhci-hcd.o and built-in.o are the culprits.  Now, if only
  I knew what the rest meant.  :)  They're referring to a symbol 
  R_386_32?  I'm going to assume this is an x86-based bit of stuff
  included from the x86-specific stuff.  Teach me.  ;)

-Joseph
--
Joseph======================================================jap3003@ksu.edu
"Ich bin ein Penguin."  --/. poster mmarlett, responding to news that the
  Bundestag will move to IBM/SuSE Linux.  
                      http://slashdot.org/comments.pl?sid=33588&cid=3631032
