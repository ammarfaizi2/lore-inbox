Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271692AbRICNQ3>; Mon, 3 Sep 2001 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271694AbRICNQK>; Mon, 3 Sep 2001 09:16:10 -0400
Received: from matrix.fr.professo.net ([213.11.43.1]:49929 "EHLO
	fr.professo.net") by vger.kernel.org with ESMTP id <S271692AbRICNP7>;
	Mon, 3 Sep 2001 09:15:59 -0400
Message-ID: <008801c1347a$9bb269e0$c200a8c0@professo.lan>
From: "Ghozlane Toumi" <gtoumi@messel.emse.fr>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
        "Benjamin Gilbert" <bgilbert@backtick.net>
Cc: <linux-kernel@vger.kernel.org>,
        "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <26751224E05@vcnet.vc.cvut.cz>
Subject: Re:Re: matroxfb problems with dualhead G400
Date: Mon, 3 Sep 2001 15:15:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, September 03, 2001 4:51 PM, You wwrote:
> On  3 Sep 01 at 0:25, Benjamin Gilbert wrote:
> > [ software scroll back kills on dualhead ]
>
> You must boot your kernel with 'video=scrollback:0'. Otherwise your
> kernel die sooner or later... JJ's scrollback code does not cope with
> more than one visible console, so you must disable it if you have more
> than one display in the box.
>                                                 Petr Vandrovec

could we somehow detect in register_framebuffer that whe're going
multihead and disable software scrolling ?

I didn't look at the code so i don't know if it's feasible , just a
suggestion ..

ghoz

