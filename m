Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282056AbRLSJLd>; Wed, 19 Dec 2001 04:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRLSJLY>; Wed, 19 Dec 2001 04:11:24 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:19616 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S282056AbRLSJLQ>;
	Wed, 19 Dec 2001 04:11:16 -0500
Message-ID: <F5FEAC407A690E42BD26E4F145301942290568@esebe002.NOE.Nokia.com>
From: Mika.Liljeberg@nokia.com
To: alan@lxorguk.ukuu.org.uk, Mika.Liljeberg@welho.com
Cc: kuznet@ms2.inr.ac.ru, davem@redhat.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi, rmk@arm.linux.ORG.UK
Subject: RE: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Date: Wed, 19 Dec 2001 11:10:54 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: ext Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]:
> > Ahh, I see. There's a kernel exception handler that is 
> > supposed to fix misaligned access? Hacky.
> 
> Its a big performance win to only do fixups for the unusual cases.

I didn't mean "hacky" as a criticism and I can see the advantages (even
though "fast pathing" the TCP slow path seems a bit strange to me). But if
this isn't a hack (in the archaic sense of the word) I don't know what is.
:-)

Regards,

	MikaL
