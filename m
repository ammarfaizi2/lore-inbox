Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRC0W5h>; Tue, 27 Mar 2001 17:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131693AbRC0W51>; Tue, 27 Mar 2001 17:57:27 -0500
Received: from anime.net ([63.172.78.150]:56337 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131666AbRC0W5I>;
	Tue, 27 Mar 2001 17:57:08 -0500
Date: Tue, 27 Mar 2001 14:55:28 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <3AC1109A.8459E52@transmeta.com>
Message-ID: <Pine.LNX.4.30.0103271454190.2234-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, H. Peter Anvin wrote:
> c) Make sure chown/chmod/link/symlink/rename/rm etc does the right thing,
> without the need for "tar hacks" or anything equivalently gross.

write-through filesystem, like overlaying a r/w ext2 on top of an iso9660
fs.

-Dan

