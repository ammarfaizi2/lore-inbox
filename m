Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286325AbRLTSd3>; Thu, 20 Dec 2001 13:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286320AbRLTSdT>; Thu, 20 Dec 2001 13:33:19 -0500
Received: from h24-82-28-170.ed.shawcable.net ([24.82.28.170]:64006 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S286318AbRLTSdD>;
	Thu, 20 Dec 2001 13:33:03 -0500
From: Maciek Nowacki <maciek@mzn.dyndns.org>
Date: Thu, 20 Dec 2001 11:32:52 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc2 -- unresolved symbols
Message-ID: <20011220183252.GA24287@mzn.dyndns.org>
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0112181824020.4821-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling everything as modules yields some unresolved symbols (UP):

depmod: *** Unresolved symbols in modules/kernel/drivers/net/wan/comx.o
depmod: *** Unresolved symbols in modules/kernel/fs/binfmt_elf.o

(binfmt_elf compiled as module since Christian Koenig's multiboot patches
theoretically allow this.. but I can't really test :-( )

More info (.config, ...?) available upon request.

Maciek
