Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291222AbSBMAgr>; Tue, 12 Feb 2002 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291273AbSBMAgi>; Tue, 12 Feb 2002 19:36:38 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58384 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291222AbSBMAg0>;
	Tue, 12 Feb 2002 19:36:26 -0500
Date: Tue, 12 Feb 2002 22:36:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <E16anPg-0003cy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202122225410.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Alan Cox wrote:

> > I don't see why it should be different for applications
> > that write data after sync has started.
>
> The guarantee about data written _before_ the sync started is also
> being broken unless I misread the code

Hmm, I guess we will want to fix that part ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

