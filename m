Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286456AbSABAz3>; Tue, 1 Jan 2002 19:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSABAzT>; Tue, 1 Jan 2002 19:55:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1542 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286456AbSABAzJ>; Tue, 1 Jan 2002 19:55:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Date: 1 Jan 2002 16:54:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0tlos$e6m$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <4.3.2.7.2.20011231090710.00ab7e30@192.168.124.1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4.3.2.7.2.20011231090710.00ab7e30@192.168.124.1>
By author:    Roy Hills <linux-kernel-l@nta-monitor.com>
In newsgroup: linux.dev.kernel
> 
> My understanding is that the problem is something to do with the
> Toshiba Tecra laptops not flushing the cache properly when activating
> the A20 line.  This causes a problem for bzImage kernels because they
> decompress into extended memory, whereas zImage kernels don't and
> thus don't tickle the bug.
> 

It's a timing problem; it has nothing to do with the cache.  The
workaround for the timing problem was added a long time ago.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
