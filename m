Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286880AbRLWMBl>; Sun, 23 Dec 2001 07:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286877AbRLWMBc>; Sun, 23 Dec 2001 07:01:32 -0500
Received: from news.cistron.nl ([195.64.68.38]:56586 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S286879AbRLWMBT>;
	Sun, 23 Dec 2001 07:01:19 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
Date: 23 Dec 2001 13:01:16 +0100
Organization: Cistron Internet Services
Message-ID: <a04h2c$nn7$1@picard.cistron.nl>
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <3C25A06D.7030408@zytor.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C25A06D.7030408@zytor.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>What concerns me about cpio in particular:

g) It is impossible to extend without changing the magic at the beginning
of the archive which will make all other cpio-handling tools not accept it.
tar does this better by having per-file types with a nice room for new
types, and older tar implementations will just skip over types they can
not handle.

This is probably not very relevant for this application, but it is something
you might want to remember if you are thinking of using cpio.

Wichert.


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

