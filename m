Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264079AbRFIIHn>; Sat, 9 Jun 2001 04:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbRFIIHd>; Sat, 9 Jun 2001 04:07:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29201 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264079AbRFIIHZ>;
	Sat, 9 Jun 2001 04:07:25 -0400
Date: Sat, 9 Jun 2001 05:07:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Derek Glidden <dglidden@illusionary.com>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <E157kwK-0000U0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0106090506130.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Alan Cox wrote:

> Similarly its desirable as paging rates increase to ensure that
> everything gets some running time to make progress even at the cost of
> interactivity. This is something BSD does that we don't. Arguably
> nowdays its reasonable to claim you should have enough ram to avoid
> the total thrash state that BSD handles this way o course

During last week's holidays I've started working on some load
control code for Linux. The basic mechanisms are working, the
only problem is that it doesn't actually prevent thrashing yet ;)

http://www.surriel.com/patches/2.4/2.4.5-ac5-swapper

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

