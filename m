Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRIEBDY>; Tue, 4 Sep 2001 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRIEBDP>; Tue, 4 Sep 2001 21:03:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269967AbRIEBDE>; Tue, 4 Sep 2001 21:03:04 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CPU context corrupt?
Date: 4 Sep 2001 18:03:11 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9n3tkf$fh8$1@cesium.transmeta.com>
In-Reply-To: <999606788.1571.12.camel@hamlet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <999606788.1571.12.camel@hamlet>
By author:    Aquila <aquila@hypox.org>
In newsgroup: linux.dev.kernel
>
> Hi
> 
> I have had this problem quite a while now: when playing tribes2 or when
> a particular CPU intensive xscreensaver is running, X would often hang.
> I used to be able to ssh from another box or use SysRq-K to kill X and
> restart (but I never figured out what the problem was).
> 
> Ever since upgrading to 2.4.9-ac3 (from 2.4.8-ac5 I believe), whenever
> it hangs in X the computer would beep and give this message in syslog:
> 
> Sep  4 21:43:41 hamlet kernel: CPU 0: Machine Check Exception:
> 0000000000000004
> Sep  4 21:43:41 hamlet kernel: Bank 1: f600200000000152 at
> 7600200000000152
> Sep  4 21:43:41 hamlet kernel: Bank 2: d40040000000017a at
> 540040000000017a
> Sep  4 21:43:41 hamlet kernel: Kernel panic: CPU context corrupt
> 
> It hangs there, and SysRq-K is no longer able to kill X properly. sshd
> stops working as well. What does this message mean? Do I have faulty
> hardware? 
> 

Yes.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
