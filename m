Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSBCRqk>; Sun, 3 Feb 2002 12:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSBCRqa>; Sun, 3 Feb 2002 12:46:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13287 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S287493AbSBCRqR>;
	Sun, 3 Feb 2002 12:46:17 -0500
Date: Sun, 3 Feb 2002 12:46:14 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Francois Romieu <romieu@cogenit.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        davem@redhat.com
Subject: Re: [PATCH] Generic HDLC patch for 2.5.3
Message-ID: <20020203124614.A10139@havoc.gtf.org>
In-Reply-To: <20020202190242.C1740@havoc.gtf.org> <E16XAnc-00010K-00@the-village.bc.nu> <20020202200332.A3740@havoc.gtf.org> <20020203181302.C12963@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020203181302.C12963@fafner.intra.cogenit.fr>; from romieu@cogenit.fr on Sun, Feb 03, 2002 at 06:13:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like.  This patch much improves things.

"SIOCDEVICE" as a constant is unacceptable, so it would need to be
SIOCWANDEVICE or something similar.

SIOCETHTOOL, for example, is an ioctl which actually provides
sub-ioctls, so that is probably a good model to follow.

More comments after I return from New York, and can review these at
length...

	Jeff


