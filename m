Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCEP3n>; Mon, 5 Mar 2001 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbRCEP1z>; Mon, 5 Mar 2001 10:27:55 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14325 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S129344AbRCEP0c>; Mon, 5 Mar 2001 10:26:32 -0500
Date: Mon, 5 Mar 2001 12:25:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: John Kodis <kodis@mail630.gsfc.nasa.gov>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
Message-ID: <Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, John Kodis wrote:
> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> 
> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'.
> 
> Unix does not, never has, and never will end a text line with ' ' (a
> space character) or with \t (a tab character).  Yet if I begin a shell
> script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
> striped and /bin/sh gets exec'd.  Since \r has no special significance
> to Unix, I'd expect it to be treated the same as any other whitespace
> character -- it should be striped, and /bin/sh should get exec'd.

Makes sense, IMHO...

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

