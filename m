Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbRDXOt3>; Tue, 24 Apr 2001 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135658AbRDXOtT>; Tue, 24 Apr 2001 10:49:19 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:35085 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S135656AbRDXOtJ>; Tue, 24 Apr 2001 10:49:09 -0400
Date: Wed, 25 Apr 2001 00:47:10 +1000
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, "Mohammad A. Haque" <mhaque@haque.net>,
        ttel5535@artax.karlin.mff.cuni.cz,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010425004710.F1245@zip.com.au>
In-Reply-To: <Pine.GSO.4.21.0104241022040.6992-100000@weyl.math.psu.edu> <E14s3wf-0002CR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14s3wf-0002CR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 24, 2001 at 03:37:34PM +0100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 03:37:34PM +0100, Alan Cox wrote:
> What role requires priviledge once the port is open ?
> 
> 	DNS lookup does not
> 	Spooling to disk does not
> 	Accepting a connection from a client does not
> 	Doing peercred auth with a client does not
> 	Copying spool articles matching the peercred to the client does not

Running procmail as the user who is to receive the email for local mail
delivery as running it with gid mail (for eg) would allow one user to
modify another's mail.

(just a thought - the above's valid with sendmail at least)

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

