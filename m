Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131798AbRCOTdX>; Thu, 15 Mar 2001 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRCOTdQ>; Thu, 15 Mar 2001 14:33:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:23309 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131798AbRCOTcs>; Thu, 15 Mar 2001 14:32:48 -0500
Date: Thu, 15 Mar 2001 23:44:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: William T Wilson <fluffy@snurgle.org>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <Pine.LNX.4.21.0103151421380.22425-100000@benatar.snurgle.org>
Message-ID: <Pine.LNX.4.33.0103152344260.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, William T Wilson wrote:

> it seems to me that in 2.2.x it looks like this:
>
> total usage == swap + RAM
> under 2.4.x it looks like:
> total usage == swap

  total usage == maximum(swap, ram)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

