Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRGLCAp>; Wed, 11 Jul 2001 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbRGLCAf>; Wed, 11 Jul 2001 22:00:35 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18674 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S267418AbRGLCAV>; Wed, 11 Jul 2001 22:00:21 -0400
Date: Thu, 12 Jul 2001 11:00:11 +0900
Message-ID: <ofqqsy8k.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: David Ford <david@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1244! (and slab.c:580)
In-Reply-To: <3B4C810A.8070500@blue-labs.org>
In-Reply-To: <3B4C810A.8070500@blue-labs.org>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Wed, 11 Jul 2001 12:38:34 -0400,
David Ford wrote:
> 
> Hrm.  Third time I've reported this, it's happened since the early 2.4 
> kernels and I can get at least one every day or so.  The odd thing is 
> that the first oops normally happens within a couple hours after boot 
> but it may take weeks before another oops will happen.  The oops always 
> has a trace similar to below.  The second oops is new to me, it happened 
> last night and I haven't seen it before, culled from syslog.
> 
> # uname -r
> 2.4.5-ac15

  2.4.5-ac19 fixes the minor tty layer bug which modifies the memory after 
kfree() was called and it causes Oops if memory allocations debugging is enabled.
So, upgrading to newer kernel may fix your problem.
