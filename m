Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285147AbRLFOY7>; Thu, 6 Dec 2001 09:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285153AbRLFOYt>; Thu, 6 Dec 2001 09:24:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37638 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285149AbRLFOYj>; Thu, 6 Dec 2001 09:24:39 -0500
Date: Thu, 6 Dec 2001 12:24:21 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
        "David S. Miller" <davem@redhat.com>, <lm@bitmover.com>,
        <Martin.Bligh@us.ibm.com>, <lars.spam@nocrew.org>,
        <alan@lxorguk.ukuu.org.uk>, <hps@intermeta.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: SMP/cc Cluster description
In-Reply-To: <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L.0112061223520.1282-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Davide Libenzi wrote:
> On Thu, 6 Dec 2001, Rusty Russell wrote:
>
> > I'd love to say that I can solve this with RCU, but it's vastly non-trivial
> > and I haven't got code, so I'm not going to say that. 8)
>
> Lockless algos could help if we're able to have "good" quiescent point
> inside the kernel. Or better have a good quiescent infrastructure to
> have lockless code to plug in.

Machines get dragged down by _uncontended_ locks, simply
due to cache line ping-pong effects.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

