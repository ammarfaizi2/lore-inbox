Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262029AbSI3L4W>; Mon, 30 Sep 2002 07:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262030AbSI3L4W>; Mon, 30 Sep 2002 07:56:22 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:53161 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262029AbSI3L4V>;
	Mon, 30 Sep 2002 07:56:21 -0400
Date: Mon, 30 Sep 2002 22:01:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps forever)
Message-Id: <20020930220130.6c4dd808.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.43.0209301300200.462-100000@thinkpad.objectsecurity.cz>
References: <20020925225230.0028639b.sfr@canb.auug.org.au>
	<Pine.LNX.4.43.0209301300200.462-100000@thinkpad.objectsecurity.cz>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On Mon, 30 Sep 2002 13:03:19 +0200 (CEST) Karel Gardas <kgardas@objectsecurity.com> wrote:
>
> But you don't have clean 2.4.19.

True, I should try that.

> I've done it right now and it seems 2.4.19 w/o any patch is broken for me.
> i.e. it behaves the same wrong way and hd is sleeping forevere after apm
> resume...
> 
> Anything what should I test now?

Can you try 2.4.19 with the arch/i386/kernel/apm.c from 2.4.18?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
