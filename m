Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279488AbRJ3J2H>; Tue, 30 Oct 2001 04:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279483AbRJ3J2A>; Tue, 30 Oct 2001 04:28:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20241 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279488AbRJ3J1n>; Tue, 30 Oct 2001 04:27:43 -0500
Subject: Re: Nasty suprise with uptime
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Tue, 30 Oct 2001 09:33:57 +0000 (GMT)
Cc: neale@lowendale.com.au (Neale Banks), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <20011029234615.A14476@mikef-linux.matchmail.com> from "Mike Fedyk" at Oct 29, 2001 11:46:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yVHR-0005uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If so, approximtely when did that get fixed?
> > 
> > (I'm thinking back to an as yet unexplained crash of a 2.0.38 system at
> > ~496days uptime :-( )
> > 
> AFAIK, the system didn't crash, but the uptime counter went down to zero.

Some drivers used to get handling the wrap wrong and then break. Also in
the older kernels the alpha floppy driver only worked for the first 25 of
each 50 days
