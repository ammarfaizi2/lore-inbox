Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVJCW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVJCW5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJCW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:57:11 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:50358 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932445AbVJCW5K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RkCLlidaY0iJhxxJAd0vmsBVkxWZulVmjFJ35M7xL4b9cI58RrMr/zcxhB2lomiOAvHLfHfmLCfWflya1afqiHfM8xNh5lNvEgnvL8BTckDNo/+6oVybgX33oVtDhKDZd06mPDmbuY3o7MdNt/S+VuVYFl/2kwljqdRLhMkpUCU=
Message-ID: <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com>
Date: Tue, 4 Oct 2005 00:57:09 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andersen@codepoet.org, axboe@suse.de
In-Reply-To: <20051003230421.GE7554@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510040017.57168.jesper.juhl@gmail.com>
	 <20051003230421.GE7554@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> > --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> > +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c
>
> What was wrong with these ones? [snipping the rest]
>

Nothing much, simply that as far as I know, the common coding style is
that function declarations/definitions should be on one line and if
that line can't fit in 80 chars then arguments are moved to the next
line and indented by two tabs. That's the style I believe is the most
official one (if such a thing exists), so that's the style I changed
everything throughout the file to obey.


> >  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> > -                        struct request_sense *sense)
> > +             struct request_sense *sense)
>
> > -static
> > -void cdrom_analyze_sense_data(ide_drive_t *drive,
> > -                           struct request *failed_command,
> > -                           struct request_sense *sense)
> > +static void cdrom_analyze_sense_data(ide_drive_t *drive,
> > +             struct request *failed_command, struct request_sense *sense)
>
> >  static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
> > -                                   struct request *failed_command)
> > +             struct request *failed_command)
>
> >  static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
> > -                                               int xferlen,
> > -                                               ide_handler_t *handler)
> > +             int xferlen, ide_handler_t *handler)
>
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
