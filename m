Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135684AbRDXPyY>; Tue, 24 Apr 2001 11:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135685AbRDXPyO>; Tue, 24 Apr 2001 11:54:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135684AbRDXPyG>; Tue, 24 Apr 2001 11:54:06 -0400
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
To: cat@zip.com.au (CaT)
Date: Tue, 24 Apr 2001 16:53:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque),
        ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010425011132.H1245@zip.com.au> from "CaT" at Apr 25, 2001 01:11:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s57p-0002LM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. email -> sendmail
> 2. sendmail figures out what it has to do with it. turns out it's deliver
...

> Now, in order for step 4 to be done safely, procmail should be running
> as the user it's meant to deliver the mail for. for this to happen
> sendmail needs to start it as that user in step 3 and to do that it
> needs extra privs, above and beyond that of a normal user.

	email -> sendmail
	sendmail 'its local' -> spool

user:
	get_mail | procmail
	mutt

The mail server doesnt need to run procmail. If you wanted to run mail batches
through on a regular basis you can use cron for it, or leave a daemon running

	
