Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSH1AB5>; Tue, 27 Aug 2002 20:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSH1AB5>; Tue, 27 Aug 2002 20:01:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46862 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317404AbSH1AB5>; Tue, 27 Aug 2002 20:01:57 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is it possible to use 8K page size on a i386 pc?
Date: 27 Aug 2002 17:06:08 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <akh45g$jdl$1@cesium.transmeta.com>
References: <mailman.1030474690.4302.linux-kernel2news@redhat.com> <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200208271914.g7RJEQE07821@devserv.devel.redhat.com>
By author:    Pete Zaitcev <zaitcev@redhat.com>
In newsgroup: linux.dev.kernel
> 
> You may run into trouble with something that calls mmap with
> a fixed address, with executables which have text sizes of
> odd number of small pages. I was told that these problems are
> fairly rare.
> 

Only 50% of all binaries are affected... that's fairly rare :)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
