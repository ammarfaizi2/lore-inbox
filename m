Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbRESSF5>; Sat, 19 May 2001 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261932AbRESSFr>; Sat, 19 May 2001 14:05:47 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25580 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261930AbRESSFh>;
	Sat, 19 May 2001 14:05:37 -0400
Date: Sat, 19 May 2001 20:05:02 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191805.UAA51010.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, aaronl@vitelus.com
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code inuserspace
Cc: andrewm@uow.edu.au, bcrl@redhat.com, clausen@gnu.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> initrd is an unnecessary pain in the ass for most people.
> It had better not become mandatory.

You would not notice the difference, only your kernel would be
a bit smaller and the RRPART ioctl disappears.

[Besides: we have lived with DOS-type partition tables for ten years,
but they will not last another ten years. Very soon disk partitions
will look very different. It will be good to move knowledge about
these things out of the kernel before this happens.]

Andries
