Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTBTIm2>; Thu, 20 Feb 2003 03:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTBTIm2>; Thu, 20 Feb 2003 03:42:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:34284 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261836AbTBTIm2>;
	Thu, 20 Feb 2003 03:42:28 -0500
Date: Thu, 20 Feb 2003 00:53:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
Message-Id: <20030220005355.18627dde.akpm@digeo.com>
In-Reply-To: <20030220083754.23733.qmail@linuxmail.org>
References: <20030220083754.23733.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2003 08:52:26.0095 (UTC) FILETIME=[642DFFF0:01C2D8BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo Ciarrocchi" <ciarrocchi@linuxmail.org> wrote:
>
> Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-3 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-4 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-5 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-6 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-7 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-8 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-9 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-10 extents:1
> Adding 272120k swap on /dev/hda7.  Priority:-11 extents:1
>
> What happened ?
> 

Something ran swapon and swapoff a lot of times.  It appears that
your initscripts have become confused.
