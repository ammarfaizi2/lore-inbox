Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131971AbRAER1j>; Fri, 5 Jan 2001 12:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131848AbRAER1a>; Fri, 5 Jan 2001 12:27:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50182 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130401AbRAER1M>; Fri, 5 Jan 2001 12:27:12 -0500
Subject: Re: Looking for maintainer of ENSONIQ SoundScape driver
To: rankinc@zipworld.com.au
Date: Fri, 5 Jan 2001 17:28:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
In-Reply-To: <200101051717.f05HH0A01471@wittsend.ukgateway.net> from "Chris Rankin" at Jan 05, 2001 05:17:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EafV-00085w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Look for request_resource/free_resource mismatches 
> 
> The detect_sscape_pnp() routine seems to expect check_region() to
> allocate resources, although if that's true, it's rather cavalier

check_region tests they are free. Request_region allocates them (and in 2.4
tests also)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
