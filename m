Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVKWJLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVKWJLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 04:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKWJLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 04:11:40 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:18891 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030381AbVKWJLi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 04:11:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXCsgBFRNJAmOPu0MEWkcaARJMogiUwfuoXjwMMeYli23jgiqpkcowvWt5najr+V2EcIw8s5dgOYmM81N+CdbyYXOWaZLeAdjL+XYh6pCJAzrpAsCHR6HKcFFGd2XJ8Fcjv5juc5InRQwPifQCli6XIrDLCdRU4DeMVdxXDdTr0=
Message-ID: <58cb370e0511230105u430740a7ue0f945570972e1c5@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:05:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to use new blk_ordered
Cc: Jens Axboe <axboe@suse.de>, jgarzik@pobox.com,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
In-Reply-To: <43842FC9.3050202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117153509.B89B4777@htj.dyndns.org>
	 <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
	 <437DEE35.9060901@gmail.com>
	 <58cb370e0511180759u4cb50535gfd7b96100a0bd70f@mail.gmail.com>
	 <20051122024401.GB10213@htj.dyndns.org>
	 <58cb370e0511220036r6e61b509i3bc1f7ce90178b1d@mail.gmail.com>
	 <20051123072332.GA6653@htj.dyndns.org>
	 <58cb370e0511230040k6bc53862xac35979eaf1f0634@mail.gmail.com>
	 <20051123084655.GV15804@suse.de> <43842FC9.3050202@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Tejun <htejun@gmail.com> wrote:

<...>

> Hi, Bartlomiej.  Hi, Jens.
>
> Currently, there are only two more things to do before getting this
> thing into the -mm tree.
>
> 1. Adjusting this patch (update-ide) after merging Bartlomiej's
> del_gendisk() fix patch.

This should be in the mainline today/tomorrow as it is obviously correct
and I need to push another IDE update anyway (new HW support).

> 2. Update ide-fua patch as discussed and get it reviewed by Bartlomiej.
>
> Other than above two, I think we're ready.  I'll post update ide-fua
> patch later today.
>
> Thanks.
>
> --
> tejun
