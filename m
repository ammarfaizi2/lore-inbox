Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTANTlS>; Tue, 14 Jan 2003 14:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTANTlS>; Tue, 14 Jan 2003 14:41:18 -0500
Received: from [66.70.28.20] ([66.70.28.20]:53771 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265066AbTANTlR>; Tue, 14 Jan 2003 14:41:17 -0500
Date: Tue, 14 Jan 2003 20:50:05 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114195005.GD162@DervishD>
References: <20030114191420.GA162@DervishD> <Pine.LNX.3.95.1030114143919.13702A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.3.95.1030114143919.13702A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard :)

> >     Any header where I can see the length for argv[0] or is this some
> > kind of unoficial standard? Just doing strcpy seems dangerous to me
> > (you can read 'paranoid'...).
> They need to have space for _POSIX_PATH_MAX (512 bytes), to
> claim POSIX compatibility so any POSIX system will have at
> least 512 bytes available because the pathname of the executable
> normally goes there.

    Enough for me, then. Thanks a lot :)) Just one more thing: in my
Single Unix Spec v3 says that the minimum value of _POSIX_PATH_MAX is
256, not 512, and the libc manual says just the same :??

    Anyway, 256 bytes is a fair large amount ;))))

    Thanks again, Richard.

    Raúl
