Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbSJEJqZ>; Sat, 5 Oct 2002 05:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262282AbSJEJqZ>; Sat, 5 Oct 2002 05:46:25 -0400
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:56734 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S262276AbSJEJqZ>; Sat, 5 Oct 2002 05:46:25 -0400
Message-Id: <5.1.0.14.2.20021005194507.031018c0@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 05 Oct 2002 19:49:29 +1000
To: Linus Torvalds <torvalds@transmeta.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] direct-IO API change
Cc: Andrew Morton <akpm@digeo.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0210041621170.2526-100000@home.transmeta.com
 >
References: <3D9E1847.F6DDA3AE@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:23 PM 4/10/2002 -0700, Linus Torvalds wrote:
>Especially since I thought that O_DIRECT on the regular file (or block
>device) performed about as well as raw does anyway these days? Or is that
>just one of my LSD-induced flashbacks?

from my multiple 64/66 PCI bus + multiple 2gbit/s FC HBA tests, yes, 
they're around the same.
(now up to 390mbyte/sec throughput on latest & greatest x86 hardware i 
have; front-side-bus no longer the limiting factor, but dual 64/66 PCI).

of course, purely synthetic tests designed to stress Fibre Channel 
switching infrastructure, not real-world disk i/o..


cheers,

lincoln.

