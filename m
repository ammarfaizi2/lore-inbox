Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269570AbRHAAfw>; Tue, 31 Jul 2001 20:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269571AbRHAAfm>; Tue, 31 Jul 2001 20:35:42 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:59940 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S269570AbRHAAfi>;
	Tue, 31 Jul 2001 20:35:38 -0400
Message-Id: <200108010035.CAA1058949@mail.takas.lt>
Date: Wed, 1 Aug 2001 02:35:09 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: cannot copy files larger than 40 MB from CD
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.LNX.4.10.10108010028220.18588-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10108010028220.18588-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001 00:29:25 +0000 (GMT) Mark Hahn <hahn@coffee.psychology.mcmaster.ca> wrote:

MH> > Just began to use 2.4.7 instead of 2.2.19. If I copy file larger than 40 MB,
MH> > only these 40 MB are copied (40960000 bytes exactly), and then cp
MH> > segfaults (the same happens with mc). The same problem is with mkisofs -
MH> > only 40 MB of image is created. I get "File size limit exceeded".
MH> 
MH> type "ulimit -a" and look at /etc/security/limits.conf

Thanks a lot, that was exactly it! I probably lied that cp segfaulted - but mc did.
Will report to mc-devel.

Regards,
Nerijus


