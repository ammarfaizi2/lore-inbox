Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271257AbRHZDc0>; Sat, 25 Aug 2001 23:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271252AbRHZDcQ>; Sat, 25 Aug 2001 23:32:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:27410 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271254AbRHZDcI>;
	Sat, 25 Aug 2001 23:32:08 -0400
Date: Sun, 26 Aug 2001 00:32:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Marc A. Lehmann" <pcg@goof.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826013155Z16205-32383+1383@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108260030390.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Daniel Phillips wrote:

> Reality check time.

> Let's test the idea that readahead is the problem.  If it is, then
> disabling readahead should make the lowlevel disk throughput match the
> highlevel throughput.

Reality check time indeed.  If you propose that disabling
readahead should improve read performance something fishy
is going on ;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

