Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130866AbRBASqB>; Thu, 1 Feb 2001 13:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbRBASpw>; Thu, 1 Feb 2001 13:45:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129071AbRBASpk>; Thu, 1 Feb 2001 13:45:40 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 1 Feb 2001 18:46:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hch@caldera.de (Christoph Hellwig),
        sct@redhat.com (Stephen C. Tweedie), bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0102011637420.1321-100000@duckman.distro.conectiva> from "Rik van Riel" at Feb 01, 2001 04:39:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OOkB-0004qd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OTOH, somehow a zero-copy system which converts the zero-copy
> metadata every time the buffer is handed to another subsystem
> just doesn't sound right ...
> 
> (well, maybe it _is_, but it looks quite inefficient at first
> glance)

I would certainly be a lot happier if there is a single sensible zero copy
format doing the lot, but only if it doesnt turn into a cross between a 747
and bicycle
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
