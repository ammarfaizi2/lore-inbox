Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130131AbRBPJv7>; Fri, 16 Feb 2001 04:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRBPJvt>; Fri, 16 Feb 2001 04:51:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61710 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130131AbRBPJva>; Fri, 16 Feb 2001 04:51:30 -0500
Subject: Re: ServeRaid 4M with IBM netfinity and kernel 2.4.x
To: stef@via.ecp.fr (Stéphane Borel)
Date: Fri, 16 Feb 2001 09:51:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010216032956.B11267@via.ecp.fr> from "Stéphane Borel" at Feb 16, 2001 03:29:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ThY4-0002fH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a problem here that make the filesystem crash during big files
> transfer (>1M). It only happens with kernel 2.4.x ; with 2.2.18, it is
> very stable and fast.

I don't believe IBM have provided an 'official' 2.4 patch set for the serveraid
yet so there may be bugs lurking.

> I should add that the behaviour of serveraid under 2.4 is somehow
> strange : during fsck for instance, it seems to get stuck and won't go
> further if we don't strike a key on the keyboard.

Yes this has also been seen. At the time you have to do this it appears that
the Linux system is not waiting for the keyboard. It only happens on specific
IBM netfinities too. Perhaps someone at IBM can trace it down a bit further
since I certainly suspect we upset the firmware.

Alan

