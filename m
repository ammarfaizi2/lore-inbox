Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131093AbQKCSUu>; Fri, 3 Nov 2000 13:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131112AbQKCSUk>; Fri, 3 Nov 2000 13:20:40 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:47120 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S131093AbQKCSUb>;
	Fri, 3 Nov 2000 13:20:31 -0500
Date: Fri, 3 Nov 2000 17:20:57 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [linux-fbdev] [PATCH] fbcon->vgacon->fbcon
In-Reply-To: <Pine.LNX.4.10.10011031513310.1627-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.21.0011031720010.17614-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I know. I wanted for vgacon to reset the video mode itself. This way ANY
> > fbdev driver can go back top vgacon. 
> 
> That won't be possible because returning to VGA text mode is chip-specific.

>From what I see in the XF4.0 tree you can. I will find out today with me
working on the tdfx driver. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
