Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQKBR6s>; Thu, 2 Nov 2000 12:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKBR62>; Thu, 2 Nov 2000 12:58:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129054AbQKBR6X>; Thu, 2 Nov 2000 12:58:23 -0500
Subject: Re: Poll and OSS API
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 2 Nov 2000 17:59:01 +0000 (GMT)
Cc: sailer@ife.ee.ethz.ch (Thomas Sailer), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011020937410.1432-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 02, 2000 09:38:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rOdi-0001jM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2 Nov 2000, Thomas Sailer wrote:
> >
> > The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
> > specifies that a select _with the sounddriver's filedescriptor
> > set in the read mask_ should start the recording.
> 
> So fix the stupid API.
> The above is just idiocy.

Its a documentation error. The implemented API does not follow it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
