Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUECBVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUECBVm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUECBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:21:42 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:54264 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263407AbUECBVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:21:38 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Giuliano Colla <copeca@copeca.dsnet.it>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Sun, 2 May 2004 18:21:33 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
In-Reply-To: <40957585.5060105@copeca.dsnet.it>
Message-ID: <Pine.LNX.4.58.0405021819220.28837@dlang.diginsite.com>
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
 <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it>
 <409276D6.9070500@gmx.net> <4092A88D.70007@copeca.dsnet.it>
 <Pine.GSO.4.58.0405021030410.7925@waterleaf.sonytel.be> <40957585.5060105@copeca.dsnet.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

except that this brings up the issue of if the GPL will allow this
linking to take place at all.

my understanding of what RMS and the FSF have said is that they don't
believe that this is allowed at all.

David Lang


On Mon, 3 May 2004, Giuliano Colla wrote:

> Date: Mon, 03 May 2004 00:26:13 +0200
> From: Giuliano Colla <copeca@copeca.dsnet.it>
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
>      Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
>      Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
>      Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
>     their license
>
> Geert Uytterhoeven ha scritto:
>
> >On Fri, 30 Apr 2004, Giuliano Colla wrote:
> >
> >
> >>It may make sense not to have anything left in the GPL directory in a
> >>binary only .rpm package, because once linked GPL parts cannot be told
> >>apart from non-GPL ones.
> >>
> >>
> >
> >When speaking about loadable kernel modules: yes they can! That's what
> >modinfo(8) is for!
> >
> >Oh wait, someone played tricks with a \0 character...
> >
> >Gr{oetje,eeting}s,
> >
> >
> >
> What I mean is that in a binary rpm you have binaries which link
> together GPL and non GPL code. There's not such a thing as a GPL
> binaries to put in the GPL directory. This holds true whether they play
> tricks or not. If you want to see the GPL'd code you must download the
> source package.
> You may blame them for playing tricks with \0 character, but you can't
> blame them for an empty GPL directory in the binary package, when you
> find it properly populated in the source package.
>
> Groetje,
> -----
> Giuliano Colla
>
> Whenever people agree with me, I always feel I must be wrong (O. Wilde)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
