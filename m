Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSJDE7p>; Fri, 4 Oct 2002 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJDE7p>; Fri, 4 Oct 2002 00:59:45 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:22943 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP
	id <S261485AbSJDE7o>; Fri, 4 Oct 2002 00:59:44 -0400
Message-ID: <000401c26b63$9ac9dc90$0a00a8c0@refresco>
From: "John Tyner" <jtyner@cs.ucr.edu>
To: "Greg KH" <greg@kroah.com>
Cc: <video4linux-list@redhat.com>, <linux-kernel@vger.kernel.org>,
       <kraxel@bytesex.org>
References: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu> <20021004045051.GB3556@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Thu, 3 Oct 2002 22:05:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you send me a patch for 2.5, I'd be glad to add it to the tree.
> Right now, I'm not accepting USB drivers that don't show up in 2.5
> first.

I'll get to work.

> Other than that, the code looks nice.  Did you look at how the usb video
> drivers do their memory management in 2.4.20-pre like I mentioned
> before?

I did. The ov511 as well as the bttv and cpia drivers still use the
rvmalloc/rvfree methods. They are minor'ly updated from the version I was
using, and I've already incorporated those changes to the driver submitted
in my previous post.

Thanks,
John

