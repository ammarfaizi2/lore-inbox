Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289112AbSAJB3U>; Wed, 9 Jan 2002 20:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSAJB3B>; Wed, 9 Jan 2002 20:29:01 -0500
Received: from hank-fep6-0.inet.fi ([194.251.242.201]:64139 "EHLO
	fep06.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S289112AbSAJB2w>; Wed, 9 Jan 2002 20:28:52 -0500
Message-ID: <3C3CEE53.3B35CCE3@pp.inet.fi>
Date: Thu, 10 Jan 2002 03:28:51 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] linux-2.0.40-rc1
In-Reply-To: <20020109003424.S5235@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> Hence I'm declaring this the first release candidate for 2.0.40.
> Try it out, please.
> 
> 2.0.40-rc1
[snip]
> o       Change array-size from 0 to 1 for       (me)
>         two arrays in the symbol-table
>         in include/linux/module.h

Please revert above change. It makes struct symbol_table.symbol[] one entry
long, and effectively _kills_ module support.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

