Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281762AbRKUOU4>; Wed, 21 Nov 2001 09:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKUOUq>; Wed, 21 Nov 2001 09:20:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:61709 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281381AbRKUOUg>; Wed, 21 Nov 2001 09:20:36 -0500
Date: Wed, 21 Nov 2001 12:20:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "David S. Miller" <davem@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 + Bug in swap_out.
In-Reply-To: <m1hero1c8o.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0111211219420.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2001, Eric W. Biederman wrote:

> We only hold a ref count for the duration of swap_out_mm.
> Not for the duration of the value in swap_mm.

In that case, why can't we just take the next mm from
init_mm and just "roll over" our mm to the back of the
list once we're done with it ?

Removing magic is good ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

