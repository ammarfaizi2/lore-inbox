Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319457AbSILGmh>; Thu, 12 Sep 2002 02:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319458AbSILGmh>; Thu, 12 Sep 2002 02:42:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:744 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319457AbSILGmg>;
	Thu, 12 Sep 2002 02:42:36 -0400
Date: Thu, 12 Sep 2002 08:47:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Alan Cox <alan@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre5-ac4 hda lost interrupt
Message-ID: <20020912064712.GL30234@suse.de>
References: <200209092236.g89MamX04399@devserv.devel.redhat.com> <Pine.LNX.4.21.0209102031340.5006-100000@ppg_penguin.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0209102031340.5006-100000@ppg_penguin.linux.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10 2002, Ken Moffat wrote:
> On Mon, 9 Sep 2002, Alan Cox wrote:
> 
> > 
> > The timeout is interesting in itself. Does it go away if you disable
> > IDE taskfile I/O ?
> > 
> 
>  If you mean, do the "lost interrupt" messages go away, the answer is yes,
> and the system is as responsive as any other with a chronically slow disk.
> Ctrl-alt-del is working again too.

Same problem is in 2.5.34-BK, I disabled the option to even select
taskfile i/o until this is looked at. Alan, I think that it would be a
good idea to do the same for 2.4-ac

-- 
Jens Axboe

