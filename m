Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281912AbRKZQgU>; Mon, 26 Nov 2001 11:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRKZQgL>; Mon, 26 Nov 2001 11:36:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11524 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281912AbRKZQgI>; Mon, 26 Nov 2001 11:36:08 -0500
Date: Mon, 26 Nov 2001 14:35:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ben Greear <greearb@candelatech.com>, Ben Greear <greearb@agcs.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
In-Reply-To: <Pine.GSO.3.96.1011126165647.21598T-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33L.0111261435090.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Maciej W. Rozycki wrote:

>  It appears the 802.1Q VLAN support didn't receive even basic testing,
> sigh...  It doesn't compile non-modular, due to vlan_proc_cleanup() being
> discarded, yet needed in vlan_proc_init().  Following is a fix.

OK, does anybody have good scripts for automatically compiling
the kernel with many random configurations so we can discover
bugs like this automagically ?

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

