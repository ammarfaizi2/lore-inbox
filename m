Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261984AbREST20>; Sat, 19 May 2001 15:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbREST2R>; Sat, 19 May 2001 15:28:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46322 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261979AbREST2L>;
	Sat, 19 May 2001 15:28:11 -0400
Date: Sat, 19 May 2001 21:27:38 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191927.VAA52803.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, pavel@suse.cz, viro@math.psu.edu
Subject: Re: mount misbehaviour?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> root@bug:/zip# mount /zip
> root@bug:/zip# ls -al
> total 8
> drwxr-xr-x    2 root     root         4096 Dec  1 08:29 .
> drwxr-xr-x   31 65534    root         4096 Apr 24 20:56 ..
> root@bug:/zip# cd /zip
> root@bug:/zip# ls -al
> total 22182
> ...

> Is that okay?

Yes. Your working directory does not change when you mount something.

