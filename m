Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSFDQQD>; Tue, 4 Jun 2002 12:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSFDQQD>; Tue, 4 Jun 2002 12:16:03 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:49426 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S314475AbSFDQQC> convert rfc822-to-8bit; Tue, 4 Jun 2002 12:16:02 -0400
Date: Tue, 4 Jun 2002 18:16:00 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
X-X-Sender: moffe@grignard
To: tabris <tabris@tabris.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <jgarzik@mandrakesoft.com>
Subject: Re: Failure report: tulip driver
In-Reply-To: <20020604152307.B8D81FB911@tabriel.tabris.net>
Message-ID: <Pine.LNX.4.44.0206041811010.1201-100000@grignard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, tabris wrote:

> On Tuesday 04 June 2002 10:18, Rasmus Bøg Hansen wrote:
> > [1.] One line summary of the problem:
> >
> > tulip.o gives transmit timeouts and a reboot is needed.
>
> I'd like to say I reported this same problem a couple months ago...
>
> 1) I think it might be partly a timing/temperature issue.

I do not *think* it is a temperature issue. The box is in good
environment and does not generate much heat - however I cannot check
that for a week or two.

For the timing issues, I do not know.

> 2) it is possible to recover simply by ifdown the interfaces, then rmmod
> the module (assuming it is compiled as module...), then ifup the ifaces
> again.

I cannot do this as it is statically linked into the kernel, but you are
probably right.

> 3) I'm cc'ing this to Jeff Garzik, as I think he is the current
> maintainer of the tulip driver.

Sorry, should have done that from the start - I just forgot.

/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Life is that property, which a being will lose as a result of falling
out of a cold and mysterious cave 30 miles above ground level.
                     - HitchHikers Guide to the Galaxy, Douglas Adams
----------------------------------[ moffe at amagerkollegiet dot dk ] --



