Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVD1UtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVD1UtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVD1Uqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:46:50 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:4059 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262204AbVD1UqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:46:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qfui0XbcUamu6+/oXLzO6z7Kiw+qWwENueaLaeiosdyHrJKiNF4rsqcQ78ZztfJsqrD4O+xo/0mVoly/xbvy/KlOymCezNcLh+u9HoVR7jzzO8JK7QZMG7fDbcWb5QblE3RBcE7FCxUU7pFIjR7YsLLagUSlouI34NQMkHLB6lM=
Message-ID: <58cb370e05042813466915eebb@mail.gmail.com>
Date: Thu, 28 Apr 2005 22:46:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: IDE problems with rmmod ide-cd
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050428172541.GN1876@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114706653.18330.212.camel@localhost.localdomain>
	 <20050428172541.GN1876@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Apr 28 2005, Alan Cox wrote:
> > If you rmmod ide-cd in 2.6.12rc3 it issues a cache flush command to the
> > drive. Thankfully the bogus command this time is an ATAPI cache flush
> > not an ATA one so won't do any major harm but its still wrong as the
> > device is not a writer or packet mode capable (its a random DVD reader
> > holding a music CD)
> 
> The problem you are thinking of was also an ATAPI cache flush command,
> so I'm not so sure I would call it harmless... I haven't changed
> anything in there recently, Bart?

I don't remember changing anything there recently.
Alan, please give more details of the issue.

Bartlomiej
