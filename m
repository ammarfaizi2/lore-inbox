Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbTACBlm>; Thu, 2 Jan 2003 20:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTACBlm>; Thu, 2 Jan 2003 20:41:42 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:56587 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267367AbTACBll>; Thu, 2 Jan 2003 20:41:41 -0500
Message-ID: <3E14EB46.21B6AD35@linux-m68k.org>
Date: Fri, 03 Jan 2003 02:45:42 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] top-level config menu dependencies
References: <20030101162519.GF15200@louise.pinerecords.com> <3E143F74.434AD08B@linux-m68k.org> <20030102195024.GC17053@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tomas Szepe wrote:

> If I understand you correctly, what you are proposing is equivalent
> to how the following currently works:
> 
> config MTD
>         tristate "Memory Technology Device (MTD) support"
> 
> menu "Memory Technology Device (MTD) support"
>         depends on MTD
> 
> ...
> 
> endmenu
> 
> It seems to me the infrastructure you've provided by kconfig
> is completely sufficient -- it's the config frontends that would
> require minor updates (xconfig mainly, menuconfig seems to be
> working nicely -- at least with the setup I outlined above).

Have you tried this with xconfig? What do you mean with "minor updates"?
I don't want to add some special magic, I'd rather make this explicit in
the syntax.

bye, Roman
