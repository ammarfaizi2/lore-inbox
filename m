Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288103AbSACB2e>; Wed, 2 Jan 2002 20:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288108AbSACB2Y>; Wed, 2 Jan 2002 20:28:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:44967 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288103AbSACB2U>;
	Wed, 2 Jan 2002 20:28:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 3 Jan 2002 01:28:16 GMT
Message-Id: <UTC200201030128.BAA192710.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, alessandro.suardi@oracle.com
Subject: Re: [PATCH] Re: NFS "dev_t" issues..
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From alessandro.suardi@oracle.com Thu Jan  3 00:22:23 2002

    Andries.Brouwer@cwi.nl wrote:
    > 
    > I see lots of people sending patches for kdev_t.
    > In order to possibly avoid duplication of work,
    > I put my patch at ftp.kernel.org:
    > 2.5.2pre6-kdev_t-diff (415841 bytes)
    > 
    > It has kminor and kmajor, but if that is not desired
    > a very simple edit on the patch will turn them into
    > minor and major.
    > 
    > (It is incomplete, but a good start.)

    It doesn't build for me in make_rdonly() in ext3 with debug
     configured in:

Yes. Still w.i.p. but a better version is now
2.5.2pre6-kdev_t-diff-v3 (443024 bytes).

Andries
