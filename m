Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbREZPdF>; Sat, 26 May 2001 11:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREZPbs>; Sat, 26 May 2001 11:31:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58886 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261351AbREZPbY>;
	Sat, 26 May 2001 11:31:24 -0400
Date: Sat, 26 May 2001 12:31:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260818150.3684-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105261229160.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Linus Torvalds wrote:

> Oh, and I still _do_ think that we should rename the silly "async"
> flag as "can_do_io", and then use that to determine whether to do
> SLAB_KERNEL or SLAB_BUFFER. That would make more things able to do IO,
> which in turn should help balance things out.

Agreed, this simplifies things a lot.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

