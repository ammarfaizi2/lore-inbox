Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129567AbRBAWfQ>; Thu, 1 Feb 2001 17:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129743AbRBAWfF>; Thu, 1 Feb 2001 17:35:05 -0500
Received: from quechua.inka.de ([212.227.14.2]:17436 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129567AbRBAWe4>;
	Thu, 1 Feb 2001 17:34:56 -0500
From: W1012@lina.inka.de
To: linux-kernel@vger.kernel.org
Subject: Re: XFS file system Pre-Release 
Message-Id: <E14OSJc-0000s6-00@sites.inka.de>
Date: Thu, 1 Feb 2001 23:34:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200102012138.f11LcV322920@jen.americas.sgi.com> you wrote:
>> What support does XFS provide for clustering?
>> 								Pavel

> This statement is a little misleading, the clustering software is other
> stuff from SGI, they just have xfs filesystems on the machines.

One reason for this is, that in a shared nothing cluster on fail over you may
have to have a filesystem check. and that is simly taking too long if you do
not have a log filesystem. Thats why reiser, jfs, xfs or ext3 makes sense here.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
