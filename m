Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRA3Qhw>; Tue, 30 Jan 2001 11:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRA3Qhm>; Tue, 30 Jan 2001 11:37:42 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:46981 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129735AbRA3Qhb>; Tue, 30 Jan 2001 11:37:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200101301630.LAA15247@renoir.op.net> 
In-Reply-To: <200101301630.LAA15247@renoir.op.net> 
To: Paul Davis <pbd@Op.Net>
Cc: Joe deBlaquiere <jadb@redhat.com>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jan 2001 16:35:48 +0000
Message-ID: <7989.980872548@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pbd@Op.Net said:
>  no, thats not the logical answer at all. the logical answer is
> something like the excellent but neglected UTIME patch that
> continually reprograms the system timer so that you can get precise
> event scheduling without the insane overhead of HZ=10000.

Indeed. Which, as an added bonus, lets me nick the system timer and 
reprogram it to 18KHz for the PC speaker driver :)

But that's a different story.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
