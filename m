Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291077AbSBMAQ0>; Tue, 12 Feb 2002 19:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291123AbSBMAQR>; Tue, 12 Feb 2002 19:16:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:5136 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291077AbSBMAQA>;
	Tue, 12 Feb 2002 19:16:00 -0500
Date: Tue, 12 Feb 2002 22:15:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16anFC-0003bD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202122215020.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:

> > > Its seems preferably to suprise data loss
> >
> > The data isn't lost, it'll simply get written out to
> > disk later.
>
> Allow me to introduce you to the off button, and the scripts at
> shutdown which use sync

Those don't protect the system against applications that
write data after sync has exited.

I don't see why it should be different for applications
that write data after sync has started.

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

