Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJPOLj>; Tue, 16 Oct 2001 10:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276305AbRJPOLa>; Tue, 16 Oct 2001 10:11:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5394 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276249AbRJPOLS>;
	Tue, 16 Oct 2001 10:11:18 -0400
Date: Tue, 16 Oct 2001 12:11:30 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <Pine.LNX.4.33.0110161503300.17096-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33L.0110161205380.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Luigi Genoni wrote:

> The reason is the aa VM is more predictable, but rik's one actually
> seems to be smarter under very very stressed situations.

This is a different approach to the situation.  Most of the
time in the early 2.4 kernels we were much too busy to stop
machines from crashing to care about performance.

Only in more recent -ac kernels have I actually had time to
look at performance and it seems to be relatively easy to
get the VM to perform better.

Andrea seems to have optimised his VM for performance under
low to medium loads from the beginning ... but in Linux 2.2
we've seen how impossible it is to tune such a simplistic
VM to not fall apart under very high loads, so I won't be
going that way ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

