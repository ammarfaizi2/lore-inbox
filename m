Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSAKChx>; Thu, 10 Jan 2002 21:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAKChn>; Thu, 10 Jan 2002 21:37:43 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:50193 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289839AbSAKChf> convert rfc822-to-8bit; Thu, 10 Jan 2002 21:37:35 -0500
Date: Thu, 10 Jan 2002 18:42:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Ed Tomlinson <tomlins@cam.org>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
In-Reply-To: <20020111021221Z289836-13997+3739@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0201101841430.1493-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> On Fri, Jan 11, 2002 at 00:52:16AM, khromy wrote:
> > On Thu, Jan 10, 2002 at 07:43:04PM -0500, Ed Tomlinson wrote:
> > > Incase I messed up removing and repatch I tried from a clean kernel with
> > > the same results.
> > > Any one else seeing this?
> >
> > Yes.. This is a PII350 with 128MiB... If anybody needs any more info let
> > me know.
>
> -H5 (-G1, latest I've tried worked)
>
> 1 GHz Athlon II, 640 MB
> hang hard right after
> Initializing RT netlink socket

Look in init/main.c, if kernel_thread() is called before init_idle().




- Davide


