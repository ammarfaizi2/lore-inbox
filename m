Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSAQKTK>; Thu, 17 Jan 2002 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288466AbSAQKS7>; Thu, 17 Jan 2002 05:18:59 -0500
Received: from miranda.axis.se ([193.13.178.2]:59030 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S288460AbSAQKSq>;
	Thu, 17 Jan 2002 05:18:46 -0500
Message-ID: <18e701c19f40$88d8fdd0$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <quinlan@transmeta.com>,
        =?iso-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
Cc: "Daniel Quinlan" <quinlan@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <15430.9334.687743.46115@sodium.transmeta.com><Pine.LNX.4.44.0201170218110.24496-100000@rudy.mif.pg.gda.pl> <15430.14470.999605.380374@sodium.transmeta.com>
Subject: Re: [PATCH] cramfs updates for 2.4.17
Date: Thu, 17 Jan 2002 11:20:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> =?ISO-8859-2?Q?Tomasz=5FK=B3oczko?= writes:
> 
> > On Wed, 16 Jan 2002, Daniel Quinlan wrote:
> > [..]
> > > mkcramfs.c
> > [..]
> > 
> > Why not move this tool to util-linux ?
> 
> I'm actually ready to move the tools to sourceforge (the cramfs tools
> CVS tree is there).
> 
>   http://sourceforge.net/projects/cramfs/
> 
> Assuming it's okay with Linus and Marcelo, I'll remove scripts/cramfs
> in the next version of the patch (which should be fine for 2.5 too).
> 
> Dan

Why move it?
Having it in the tree makes it nice and easy to use it, 
and easy keeping it in sync.
BTW: I have an improvement wish for cramfs: 
Add the date of filesystemgeneration to the image header somewhere 
and use that to update the time info in the inode, that way you could
get a cheap way of having some valid time stamp for the files without
it taking a lot of space (helps if you have a webserver and the browser 
caches stuff)
/Johan


