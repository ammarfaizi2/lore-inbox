Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBHRES>; Thu, 8 Feb 2001 12:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbRBHREI>; Thu, 8 Feb 2001 12:04:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:64239 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129846AbRBHREE>; Thu, 8 Feb 2001 12:04:04 -0500
Date: Thu, 8 Feb 2001 15:02:30 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
cc: David Weinehall <tao@acc.umu.se>, Linus Torvalds <torvalds@transmeta.com>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.21.0102081644360.12170-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0102081501410.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Hugh Dickins wrote:
> On Thu, 8 Feb 2001, David Weinehall wrote:
> > 
> > Well, after all, it's debugging code, and the code now is easy to read.
> > Your code, while more efficient, isn't. I think that clarity takes
> > priority over efficiency in non-critical code such as debugging
> > code. Of course, this is my personal opinion...
> 
> I agree my version isn't _as_ easy, and if this code only got built
> into DEBUG kernels, I would never have bothered about it; but it's
> built into every kernel, on executed paths, so it's no less critical.

Since it's DEBUG code only and nicely "hidden" in a .h file,
why not have the efficient code with a well-written comment
documenting what the code does and why it is there ?

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
