Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbTCZUbE>; Wed, 26 Mar 2003 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTCZUbE>; Wed, 26 Mar 2003 15:31:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262053AbTCZUbB>; Wed, 26 Mar 2003 15:31:01 -0500
Message-ID: <3E82107F.1060204@zytor.com>
Date: Wed, 26 Mar 2003 12:41:35 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Pavel Machek <pavel@ucw.cz>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       James Bourne <jbourne@hardrock.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
References: <3E7E4C63.908@gmx.de> <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org> <20030324003946.GA11081@wohnheim.fh-wedel.de> <3E7E736D.4020200@zytor.com> <20030324144219.GC29637@suse.de> <20030327074727.GA3021@zaurus.ucw.cz> <20030326203042.GA31359@suse.de>
In-Reply-To: <20030326203042.GA31359@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Thu, Mar 27, 2003 at 08:47:27AM +0100, Pavel Machek wrote:
> 
>  > > and have it wget patches from k.o, verify signatures and auto-apply them,
>  > > which removes the "admin didnt even know there were patches
>  > > that needed to be applied" possibility.
>  > 
>  > That looks like ugly can of worms to me.
>  > "what kernel do you have?"
>  > "2.4.25 and it did two downloads; I was
>  > compiling it on the friday night"
> 
> So make one of the patches change extra-version to -errataN or the like.
> 

Basically what we're talking about now is someone to maintain an "errata
tree" -- someone to maintain sub-point releases (2.4.25.1, .2, etc.) and
to decide what those are.

The other option would be to have it called something like
2.4.25-ep36-ep42-ep96 if errata patches 36, 42 and 96 were applied.

I think sub-point releases are better, since it at least cuts down the
number of possible combinations.

	-hpa


