Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbRCOQOm>; Thu, 15 Mar 2001 11:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131779AbRCOQOc>; Thu, 15 Mar 2001 11:14:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:4109 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131778AbRCOQOS>; Thu, 15 Mar 2001 11:14:18 -0500
Date: Thu, 15 Mar 2001 20:26:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: christophe barbe <christophe.barbe@lineo.fr>
Cc: "Mike A . Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <20010315170910.C4921@pc8.inup.com>
Message-ID: <Pine.LNX.4.33.0103152025340.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, christophe barbe wrote:

> Please Rik, could you explain what you mean with "reclaim swap
> space when we run out". In my (limited) understanding, when
> there's no more free memory (ram and swap space), the kernel
> starts to kill process (and the choice is a difficult point).
> Are you proposing to add an API to reclaim swap instead of
> killing process ?

When we swap something in from swap, it is in effect "duplicated"
in memory and swap. Freeing the swap space of these duplicates
will mean we have, effectively, more swap space.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

