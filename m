Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293095AbSCKVGZ>; Mon, 11 Mar 2002 16:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291081AbSCKVGP>; Mon, 11 Mar 2002 16:06:15 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6272 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293095AbSCKVF5>; Mon, 11 Mar 2002 16:05:57 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 11 Mar 2002 13:09:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: ide timer trbl ...
In-Reply-To: <3C8D0B56.7090505@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203111308480.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:

> Davide Libenzi wrote:
> > You guys probably already know but i'm still having problems with the ide
> > timer in 2.5.5 :
> >
> > hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> > bug: kernel timer added twice at c01c7293.
> > NFS: NFSv3 not supported.
> > nfs warning: mount version older than kernel
> > hda: ide_set_handler: handler not null; old=c01c5e10, new=c01c5e10
> > bug: kernel timer added twice at c01c7293.
>
> Hugh?
>
> It would be helpfull if you could send me the System.map
> corresponding to that, since this could make it clear
> which particular timer function is involved.
>
> lspci -v
> hdparm -i /dev/hda
>
> and so one are usefull as well of course.
>
> I was already tempted to replace the above check by a BUG()...
>
> Would you mind as well to just apply ide-clean-18 and ide-clean-19
> on top of each other and recheck?

I'll post it asap, try to check out the Alan's hint though and let me
know.



- Davide


