Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289866AbSAPWDT>; Wed, 16 Jan 2002 17:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSAPWDL>; Wed, 16 Jan 2002 17:03:11 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:30992 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290010AbSAPWC6>;
	Wed, 16 Jan 2002 17:02:58 -0500
Date: Wed, 16 Jan 2002 20:02:42 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Diego Calleja <grundig@teleline.es>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Rik spreading bullshit about VM
In-Reply-To: <20020116215449Z289156-13996+7212@vger.kernel.org>
Message-ID: <Pine.LNX.4.33L.0201162001480.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Diego Calleja wrote:
> On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> > attached) and most important I don't have a single bugreport about the
> > current 2.4.18pre2aa2 VM (except perhaps the bdflush wakeup that seems
>
> Well, I haven't reported it yet, but booting my box with mem=4M
> gave as result: (running 2.4.18-pre2aa2):
> diego# cat /var/log/messages | grep gfp
> Jan 13 15:37:10 localhost kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)

> Each script of /etc/rc.d was killed by VM when it was started,

It seems Andrea's patch backs out a bugfix for this problem
which marcelo and me put into the normal 2.4 kernel ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

