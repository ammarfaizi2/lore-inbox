Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280071AbRKEAjl>; Sun, 4 Nov 2001 19:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280074AbRKEAjb>; Sun, 4 Nov 2001 19:39:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28426 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280073AbRKEAjX>;
	Sun, 4 Nov 2001 19:39:23 -0500
Date: Sun, 4 Nov 2001 22:38:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Lonnie Cumberland <lonnie@outstep.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Special Kernel Modification
In-Reply-To: <3BE5D6EC.8040204@outstep.com>
Message-ID: <Pine.LNX.4.33L.0111042236590.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Lonnie Cumberland wrote:

> I have look into using things like "chroot" to restrict the users for
> this very special server, but that solution is not what we need.

> My problem is that I need to find a way to prevent the user from
> navigating out of their home directories.

chroot() will do that pretty well, but if you want more
you can always take a look at vserver:

http://www.solucorp.qc.ca/miscprj/s_context.hc

Not as sophisticated as NSA's selinux, but that also
means it's much easier to get security because it's
just easier to setup ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

