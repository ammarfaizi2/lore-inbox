Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSEaTov>; Fri, 31 May 2002 15:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSEaTou>; Fri, 31 May 2002 15:44:50 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:58496 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316739AbSEaTot>; Fri, 31 May 2002 15:44:49 -0400
Date: Fri, 31 May 2002 21:49:30 +0200
Organization: Pleyades
To: alan@lxorguk.ukuu.org.uk, dent@cosy.sbg.ac.at
Subject: Re: do_mmap
Cc: linux-kernel@vger.kernel.org
Message-ID: <3CF7D3CA.mail9T12XQQ09@viadomus.com>
In-Reply-To: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at>
 <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Alan & Thomas :)

>> is it possible to have 0 as a valid address? - if not, this should
>> be the return on errors.
>SuS explicitly says that 0 is not a valid mmap return address.

    Not in my copy of the SuS, version 2, but yes in my man page
about mmap(). Anyway, Linus told me that he doesn't like to change
the semantics for mmap, so it can return 0.

    I don't like mmap() returning 0, but I don't like too breaking
the old behaviour of the kernel. Moreover, 0 is returned only if the
length requested is 0 and the address passed as hint is 0 too... I
don't see any problem about it.

    Raúl
