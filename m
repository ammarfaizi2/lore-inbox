Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbRBCOaj>; Sat, 3 Feb 2001 09:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129996AbRBCOa3>; Sat, 3 Feb 2001 09:30:29 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:62732 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129997AbRBCOaN>; Sat, 3 Feb 2001 09:30:13 -0500
Date: Sat, 3 Feb 2001 15:28:56 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: bidirectional named pipe?
Message-ID: <20010203152856.A30376@pcep-jamie.cern.ch>
In-Reply-To: <EFC879D09684D211B9C20060972035B1D4684F@exchange2ca.sv.dialogic.com> <E14OxTz-0007yS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Feb 03, 2001 at 07:51:41AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > /dev/spx".  I experiemented with socket-based pipes under Linux, but I
> > couldn't gain access to them by open()ing the name.  Is there help?  I
> 
> AF_UNIX sockets are bidirectional but like all sockets use bind() and
> connect().

And that's because sockets don't behave like bidirectional fifos.
Each connection to a socket is a distinct stream.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
