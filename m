Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRC0XAH>; Tue, 27 Mar 2001 18:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131694AbRC0W75>; Tue, 27 Mar 2001 17:59:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131691AbRC0W7o>; Tue, 27 Mar 2001 17:59:44 -0500
Message-ID: <3AC11AFA.92889B47@transmeta.com>
Date: Tue, 27 Mar 2001 14:58:02 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <Pine.LNX.4.30.0103271454190.2234-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
> 
> On Tue, 27 Mar 2001, H. Peter Anvin wrote:
> > c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
> > without the need for "tar hacks" or anything equivalently gross.
> 
> write-through filesystem, like overlaying a r/w ext2 on top of an iso9660
> fs.
> 

This is not necessarily the right way to do it, since it may not carry
with it the appropriate information.  Richard, I belive, was planning to
implement this using devfsd.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
