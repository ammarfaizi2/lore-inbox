Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbSAIODs>; Wed, 9 Jan 2002 09:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSAIODj>; Wed, 9 Jan 2002 09:03:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61450 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286672AbSAIODV>;
	Wed, 9 Jan 2002 09:03:21 -0500
Date: Wed, 9 Jan 2002 12:03:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33L.0201091201330.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Roy Sigurd Karlsbakk wrote:

> > you really should try akpm's "[patch, CFT] improved disk read latency"
> > patch.  it sounds almost perfect for your application.

> It seemed like it helped first, but after a while, some 99 processes
> went Defunct, and locked. After this, the total 'bi' as reported from
> vmstat went down to ~ 900kB per sec
>
> What should I do?

I've done a little bit of low memory testing with my -rmap
VM patch, the system seems to be working just fine with 8MB
of RAM ...

If you have the time, could you try the following patch ?

	http://surriel.com/patches/2.4/2.4.17-rmap-11a


regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

