Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281871AbRKSBp0>; Sun, 18 Nov 2001 20:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281872AbRKSBpG>; Sun, 18 Nov 2001 20:45:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:18445 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281871AbRKSBpB>;
	Sun, 18 Nov 2001 20:45:01 -0500
Date: Sun, 18 Nov 2001 23:44:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: replacing the page replacement algo.
In-Reply-To: <1006129088.605.2.camel@zaphod>
Message-ID: <Pine.LNX.4.33L.0111182344150.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2001, Shaya Potter wrote:

> If I wanted to experiment with different algorithms that chose which
> page to replace (say on a page fault) what functions would I have to
> replace?

try_to_free_pages() and all the functions it calls.

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

