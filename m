Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314051AbSEAU60>; Wed, 1 May 2002 16:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314049AbSEAU6Z>; Wed, 1 May 2002 16:58:25 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:267 "EHLO
	inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S314051AbSEAU6Y>; Wed, 1 May 2002 16:58:24 -0400
Date: Wed, 1 May 2002 22:58:18 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Eugenij Butusov <dinorage@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.2.19-2.4.x. Why why why?
Message-ID: <20020501225818.A31613@bouton.inet6-interne.fr>
Mail-Followup-To: Eugenij Butusov <dinorage@wp.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020501201703.A990@matrix.awr.open.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 08:17:03PM +0200, Eugenij Butusov wrote:
Content-Description: letter
> Dear Alan,

Now we know where's the secret behind Alan's skills : he's not
an human being but a distributed soul across humans subscribed to the
lkml :-)

>  I'm writing to You because of my problem with kernels > 2.2.17.
> This kernel is the last that works on my machine. I've tried almost
> all, including 2.3.x and 2.5.x, but they simple don't work. After

The IDE support for your chipset is known to have various quirks on 2.4.18
and below.
I don't follow 2.2 kernels so I've no advice for them. For 2.4 kernels
please try at least 2.4.19-pre7 or 2.4.19-pre3-ac1.
Trying 2.3.x kernels seems a waste of time (unless you points to the precise
patch that brings instabilily to your system) and 2.5.x is audacious to say the
least.

Looking at the last kernel messages (/var/log/message) before your crashes
might help locate the problem's origin.

For guidelines on bug reporting, please take a look at the
"REPORTING-BUGS" file at the root of your kernel source tree.

LB.
