Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312386AbSDDSQc>; Thu, 4 Apr 2002 13:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSDDSQW>; Thu, 4 Apr 2002 13:16:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:52997 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312386AbSDDSQQ>;
	Thu, 4 Apr 2002 13:16:16 -0500
Date: Thu, 4 Apr 2002 15:15:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <20020404125954.C27384@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44L.0204041514480.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Arjan van de Ven wrote:
> On Thu, Apr 04, 2002 at 04:35:33PM +0100, Tigran Aivazian wrote:
> > disappeared). Then, to make your thoughts consistent you would need to
> > disable the exported interfaces required for development of a journalling
>
> You assume EXPORT_SYMBOL is an exported, stable interface
> that constitutes a GPL barrier. I disagree with
> that and I think quite a few others do too.

The fact that users have problems with different binary-only
modules not being available for the same kernel version seems
to prove that the "interface" EXPORT_SYMBOL "defines" isn't
stable.

If it was, we'd have an nvidia driver for 2.4, not a whole
serie for each 2.4.x kernel.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

