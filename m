Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131837AbRCUXyz>; Wed, 21 Mar 2001 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131844AbRCUXyq>; Wed, 21 Mar 2001 18:54:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131837AbRCUXyg>; Wed, 21 Mar 2001 18:54:36 -0500
Date: Wed, 21 Mar 2001 20:48:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Patrick O'Rourke" <orourke@missioncriticallinux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com>
Message-ID: <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Patrick O'Rourke wrote:

> Since the system will panic if the init process is chosen by
> the OOM killer, the following patch prevents select_bad_process()
> from picking init.

One question ... has the OOM killer ever selected init on
anybody's system ?

I think that the scoring algorithm should make sure that
we never pick init, unless the system is screwed so badly
that init is broken or the only process left ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

