Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315335AbSEYUci>; Sat, 25 May 2002 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSEYUcf>; Sat, 25 May 2002 16:32:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2835 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315335AbSEYUcJ>; Sat, 25 May 2002 16:32:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: isofs unhide option:  troubles with Wine
Date: 25 May 2002 13:31:46 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <acosbi$2lr$1@cesium.transmeta.com>
In-Reply-To: <1022301029.2443.28.camel@jwhiteh> <acopak$1th$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <acopak$1th$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
>
> In article <1022301029.2443.28.camel@jwhiteh>,
> Jeremy White  <jwhite@codeweavers.com> wrote:
> >
> >    3.  Make it so that isofs/dir.c still strips out hidden
> >        files, but enable isofs/namei.c to return a hidden file that
> >        is opened directly by name.
> 
> I think this is the right solution.
> 

I think we should just dump the hidden bit; if someone wants it they
can ioctl() for it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
