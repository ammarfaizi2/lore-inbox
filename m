Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281435AbRKTWU1>; Tue, 20 Nov 2001 17:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281436AbRKTWUQ>; Tue, 20 Nov 2001 17:20:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61705 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281435AbRKTWUD>;
	Tue, 20 Nov 2001 17:20:03 -0500
Date: Tue, 20 Nov 2001 20:19:47 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <20011120.141129.57454002.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0111202019170.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, David S. Miller wrote:
>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Tue, 20 Nov 2001 20:05:05 -0200 (BRST)
>
>    Consider this a VM bug, mmap() really should be more efficient.
>
> read() is always going to be faster until mmap() can
> use large page mappings for the user.  This is why
> mmap() is slower.

Uhhhh, read his original mail.  When using mmap() he had
problems with the VM doing bad page replacement, while
read() was smooth.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

