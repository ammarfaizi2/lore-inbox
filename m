Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130349AbRABRzS>; Tue, 2 Jan 2001 12:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131134AbRABRzJ>; Tue, 2 Jan 2001 12:55:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130349AbRABRyy>; Tue, 2 Jan 2001 12:54:54 -0500
Subject: Re: Compile errors: RCPCI, LANE, and others
To: daniel@kabuki.eyep.net (Daniel Stone)
Date: Tue, 2 Jan 2001 17:25:11 +0000 (GMT)
Cc: elmer@ylenurme.ee (Elmer Joandi), linux-kernel@vger.kernel.org
In-Reply-To: <20010102142920Z131090-439+7909@vger.kernel.org> from "Daniel Stone" at Jan 03, 2001 01:02:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DVBT-0002YO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > md5sum: WARNING: 11 of 12 computed checksums did NOT match
> This indicates a corrupted download.

Nope the MD5 sums are for certified versions of the isdn drivers. They should
not match

> > objcopy: Warning: Output file cannot represent architecture UNKNOWN!
> um. this is completely rooted. what compiler are you using, what
> distribution? (hint: if it's redhat 7, don't bother).

Bzzt, wrong. Red Hat 7 compiles the 2.4 tree beautifully with gcc 2.96 as well.
Please grow up.

> > i2o_block.c:595: warning: #warning "RACE"
> this is most likely a bad thing, yes.

Yeah its to remind me to fix a small race

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
