Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQKCAmh>; Thu, 2 Nov 2000 19:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbQKCAmR>; Thu, 2 Nov 2000 19:42:17 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:52228 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129849AbQKCAmN>;
	Thu, 2 Nov 2000 19:42:13 -0500
Date: Thu, 2 Nov 2000 23:42:38 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [linux-fbdev] [PATCH] fbcon->vgacon->fbcon
In-Reply-To: <20001029042228.B379@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.21.0011022340440.14650-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Matroxfb does not switch hardware to VGA mode on exit. Try doing
> 'fbset -depth 0 -a' before quitting from matroxfb.

I know. I wanted for vgacon to reset the video mode itself. This way ANY
fbdev driver can go back top vgacon. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
