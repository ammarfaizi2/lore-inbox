Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277275AbRJDXvm>; Thu, 4 Oct 2001 19:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277271AbRJDXvc>; Thu, 4 Oct 2001 19:51:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26377 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S277270AbRJDXvM>;
	Thu, 4 Oct 2001 19:51:12 -0400
Date: Thu, 4 Oct 2001 20:51:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [DATAPOINT] how max_readahead settings affect streaming throughput
In-Reply-To: <200110042306.f94N69W22095@mailb.telia.com>
Message-ID: <Pine.LNX.4.33L.0110042049450.4835-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Roger Larsson wrote:

> I question the decision to use 124 kB as default read ahead maximum.

> The example cited was a FTP server serving 100 clients. With standard
> readahead it would give 12.8 MB readahead

	[snip]

Ideally the readahead code would scale itself to use as much
memory is available, but no more and without putting pressure
on the working set too much.

I have some ideas on how to implement this and will start
testing them as soon as I have a nice test program for this.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

