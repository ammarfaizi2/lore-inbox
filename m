Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282000AbRKZTgl>; Mon, 26 Nov 2001 14:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281961AbRKZTg0>; Mon, 26 Nov 2001 14:36:26 -0500
Received: from ns.suse.de ([213.95.15.193]:45327 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282411AbRKZTf3>;
	Mon, 26 Nov 2001 14:35:29 -0500
Date: Mon, 26 Nov 2001 20:35:27 +0100
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] net/802/Makefile
Message-ID: <20011126203527.C31937@suse.de>
In-Reply-To: <20011126140645.B3014@suse.de> <Pine.LNX.4.21.0111261514070.13961-100000@freak.distro.conectiva> <20011126.112033.88487539.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011126.112033.88487539.davem@redhat.com>; from davem@redhat.com on Mon, Nov 26, 2001 at 11:20:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Mon, 26 Nov 2001 15:14:33 -0200 (BRST)
>    
>    Let the correction come to me through the 802 maintainer, please. 
> 
> Technically there is no such person currently.  At best it comes under
> "networking" and that I guess would be me.
> 
> The person who originally wrote this 802 stuff is not active anymore
> and he is only mentioned in the credits.

Can you submit that version? ;)

diff -u linuxppc_2_4/net/802/Makefile.broken linuxppc_2_4/net/802/Makefile
--- linuxppc_2_4/net/802/Makefile.broken        Mon Nov 26 13:28:56 2001
+++ linuxppc_2_4/net/802/Makefile       Mon Nov 26 20:34:22 2001
@@ -57,4 +57,5 @@
 include $(TOPDIR)/Rules.make
 
 cl2llc.c: cl2llc.pre
+       rm -f cl2llc.c
        sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c



Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
