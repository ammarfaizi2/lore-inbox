Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSAWMC6>; Wed, 23 Jan 2002 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSAWMCt>; Wed, 23 Jan 2002 07:02:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:64274 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289815AbSAWMCg>;
	Wed, 23 Jan 2002 07:02:36 -0500
Date: Wed, 23 Jan 2002 10:02:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: <m.knoblauch@teraport.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4EA3FB.93A98AB9@aitel.hist.no>
Message-ID: <Pine.LNX.4.33L.0201231001330.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Helge Hafting wrote:

	[free memory is wasted memory]

> >  Now, I think the theory itself is OK. The problem is that the stuff in
> > buffer/caches is to sticky. It does not go away when "more important"
> > uses for memory come up. Or at least it does not go away fast enough.
>
> Then we need a larger free target to cope with the slow cache freeing.

Or we make the cache freeing faster. ;)

If you have the time, you might want to try -rmap some
day and see about the cache freeing...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

