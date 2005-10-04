Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVJDGVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVJDGVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVJDGVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:21:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33339 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932368AbVJDGVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:21:21 -0400
Date: Tue, 4 Oct 2005 08:21:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andersen@codepoet.org
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Message-ID: <20051004062146.GD3511@suse.de>
References: <200510040017.57168.jesper.juhl@gmail.com> <20051003230421.GE7554@mipter.zuzino.mipt.ru> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com>
X-IMAPbase: 1124875140 56
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04 2005, Jesper Juhl wrote:
> On 10/4/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> > > --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> > > +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c
> >
> > What was wrong with these ones? [snipping the rest]
> >
> 
> Nothing much, simply that as far as I know, the common coding style is
> that function declarations/definitions should be on one line and if
> that line can't fit in 80 chars then arguments are moved to the next
> line and indented by two tabs. That's the style I believe is the most
> official one (if such a thing exists), so that's the style I changed
> everything throughout the file to obey.

That is by no means the common style. What I usually do is indent the
arguments so the match up with the first line.

> > >  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> > > -                        struct request_sense *sense)
> > > +             struct request_sense *sense)

This is a mess. So NACK on this patch. And why are you changing the
driver version for non-functional changes?

And I prefer a space after a cast. And regardless of what others may
think, I do indent cases in a switch unless it's tight for space.

-- 
Jens Axboe

