Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265183AbRF0A41>; Tue, 26 Jun 2001 20:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265188AbRF0A4R>; Tue, 26 Jun 2001 20:56:17 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:3854 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S265183AbRF0A4I>;
	Tue, 26 Jun 2001 20:56:08 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 00:53:49 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9hbaqt$dnp$2@abraham.cs.berkeley.edu>
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D1205FB@nasdaq.ms.ensim.com> <E15F3KH-0003fd-00@pmenage-dt.ensim.com> <9hbaar$4ot$1@cesium.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 993603229 14073 128.32.45.153 (27 Jun 2001 00:53:49 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Jun 2001 00:53:49 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not rocket science to populate a chroot environment with enough
files to make many interesting applications work.  Don't expect a general
solution---chroot is not a silver bullet---but it is useful.  (Note also
that whether you can populate a chroot environment sufficiently is roughly
independent of whether you called chroot(2) with root privileges or not.)
