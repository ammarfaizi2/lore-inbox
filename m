Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284139AbRLGRYI>; Fri, 7 Dec 2001 12:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLGRYA>; Fri, 7 Dec 2001 12:24:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20493 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284254AbRLGRXw>; Fri, 7 Dec 2001 12:23:52 -0500
Date: Fri, 7 Dec 2001 14:07:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <Pine.LNX.4.33.0112070033450.4486-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.21.0112071402310.22641-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Dec 2001, Dave Jones wrote:

> On Thu, 6 Dec 2001, Alan Cox wrote:
> 
> > > - Pentium IV Hyperthreading support		(Alan Cox)
> > Actually that one is  various Intel people not me 8)
> 
> Wouldn't it be better to see such things proven right in 2.5 first ?
> 
> Random things like this still appearing in 2.4 that haven't shown
> up in 2.5 yet is a little disturbing. Ok its small, and there'll be
> more 2.4pre's to get it right if anything is wrong with it, but
> the whole forward-porting features thing just seems so... backwards.

The patch does not touch "normal" x86 code: We're just using a new feature
of P4.

If any user reports problems with "hyperthreading" we can disable it by
default... 

