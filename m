Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135346AbRDWP0E>; Mon, 23 Apr 2001 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDWPZw>; Mon, 23 Apr 2001 11:25:52 -0400
Received: from leng.mclure.org ([64.81.48.142]:64776 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S135310AbRDWPYZ>; Mon, 23 Apr 2001 11:24:25 -0400
Date: Mon, 23 Apr 2001 08:24:05 -0700
From: Manuel McLure <manuel@mclure.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hang on multi-threaded X process crash
Message-ID: <20010423082405.C979@ulthar.internal.mclure.org>
In-Reply-To: <20010422230014.A979@ulthar.internal.mclure.org> <E14rcnO-0007fb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14rcnO-0007fb-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 23, 2001 at 02:38:11 -0700
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.23 02:38 Alan Cox wrote:
> Strange trace but it looks like a bug in the -ac experimental
> multithreaded
> core dump patches. I've got a couple of other reports consistent with
> them
> being broken somewhere 
> 
> Does it have to be something like mozilla (xmms also probably breaks it)
> that
> does this. If so I suspect its specific to multithreaded apps and its a
> bug
> in the core dump changes.
> 
> If so I guess I revert them

Both mozilla and aviplay (which are both multithreaded) trigger this - I
haven't tried with xmms. Simpler programs like xclock or cat don't trigger
it.

To answer the question in your other email, I don't have DRI enabled (since
tdfx.o won't load for me due to rwsem fixes - see other thread).

Thanks for your help.
-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

