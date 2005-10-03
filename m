Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVJCWxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVJCWxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJCWxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 18:53:16 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:22340 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932436AbVJCWxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 18:53:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=svSvpHniI1blbzXwRvs5WWPUkFOc0FOIfdk6bMMUKQafuvM/7CFDEmZByd7gtsUr2KtXZdhG5+HLmK8LoQ8gdlHHj00DJqEeDbe6CmOB6e0dT+UjAZrSKDBvc3/9CcV2yVgksWkd0kDTPp5f1rPKoDHCfHQ7HbZLseF7tFuOxeQ=
Date: Tue, 4 Oct 2005 03:04:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andersen@codepoet.org, axboe@suse.de
Subject: Re: [PATCH] ide-cd cleanup (casts, whitespace and codingstyle)
Message-ID: <20051003230421.GE7554@mipter.zuzino.mipt.ru>
References: <200510040017.57168.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510040017.57168.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 12:17:56AM +0200, Jesper Juhl wrote:
> --- linux-2.6.14-rc3-git3-orig/drivers/ide/ide-cd.c
> +++ linux-2.6.14-rc3-git3/drivers/ide/ide-cd.c

What was wrong with these ones? [snipping the rest]

>  static int cdrom_log_sense(ide_drive_t *drive, struct request *rq,
> -			   struct request_sense *sense)
> +		struct request_sense *sense)

> -static
> -void cdrom_analyze_sense_data(ide_drive_t *drive,
> -			      struct request *failed_command,
> -			      struct request_sense *sense)
> +static void cdrom_analyze_sense_data(ide_drive_t *drive,
> +		struct request *failed_command, struct request_sense *sense)

>  static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
> -				      struct request *failed_command)
> +		struct request *failed_command)

>  static ide_startstop_t cdrom_start_packet_command(ide_drive_t *drive,
> -						  int xferlen,
> -						  ide_handler_t *handler)
> +		int xferlen, ide_handler_t *handler)

