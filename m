Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135997AbRBEX0f>; Mon, 5 Feb 2001 18:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135932AbRBEX00>; Mon, 5 Feb 2001 18:26:26 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135979AbRBEX0O>; Mon, 5 Feb 2001 18:26:14 -0500
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
To: dank@alumni.caltech.edu
Date: Mon, 5 Feb 2001 23:20:30 +0000 (GMT)
Cc: dot@dotat.at (Tony Finch), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A7F3420.A3B10510@alumni.caltech.edu> from "Dan Kegel" at Feb 05, 2001 03:15:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Puvx-0004TB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How close is TCP_NOPUSH to behaving identically to TCP_CORK now?
> If it does behave identically, it might be time to standardize
> the symbolic name for this option, to make apps more portable
> between the two OS's.  (It'd be nice to also standardize the
> numeric value, in the interest of making the ABI's more compatible, too.)

That one isnt practical because of the way the implementations handle 
boolean options. BSD uses bitmask based option setting for the basic
options and Linus uses switch statements
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
