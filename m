Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKIJGb>; Thu, 9 Nov 2000 04:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129425AbQKIJGW>; Thu, 9 Nov 2000 04:06:22 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55302 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129091AbQKIJGK>;
	Thu, 9 Nov 2000 04:06:10 -0500
Message-ID: <3A333D47.6B839036@i.am>
Date: Sun, 10 Dec 2000 00:22:31 -0800
From: "Mark W. McClelland" <mwm@i.am>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org> <3A0896F3.AB36C3EE@mandrakesoft.com> <3A0897F5.563552AD@timpanogas.org> <3A089A01.ECAEABBD@mandrakesoft.com> <3A089A75.96C5F74@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> > The kernel isn't going non-ELF.  Too painful, for dubious advantages,
> > namely:
> >
> 
> perhaps we should extend ELF.  After all, where linux goes, gcc
> follows....

I would like to see some features added to ELF. Resource binding support
would be nice, i.e. bitmaps used internally by GUI apps and such, so
that they can be shared between processes if they are in a shared lib,
and so that the app can reload faster if the resources are cached. I
suspect this is what allows netscape to restart in < 2 sec under Windows
or OS/2, versus ~5 sec under Linux on the same system.

Executable signing or at least a CRC (optional, of course) would be nice
too. Version strings would be helpful in some cases as well (like bad
programs that don't/can't support the -v|-V|--version options, or for
automated retrieval of the information)

Sorry if these features are supported already. 

-- 
Mark McClelland
mwm@i.am
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
