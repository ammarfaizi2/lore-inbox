Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315347AbSDWVxg>; Tue, 23 Apr 2002 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315351AbSDWVxf>; Tue, 23 Apr 2002 17:53:35 -0400
Received: from zero.tech9.net ([209.61.188.187]:59909 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315347AbSDWVxc> convert rfc822-to-8bit;
	Tue, 23 Apr 2002 17:53:32 -0400
Subject: Re: [PATCH] page coloring for 2.4.18 kernel
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Jason Papadopoulos <jasonp@boo.net>, George Anzinger <george@mvista.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200204232351.01415.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 17:53:33 -0400
Message-Id: <1019598814.1465.254.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 17:51, Dieter Nützel wrote:

> Page coloring for 2.4.18+ isn't preempt save?
> 
> It gave ~10% speedup for memory intensive apps on my single  1 GHz Athlon II 
> SlotA (0,18µm, L2 512K) but look the system hard from time to time. Nothing 
> in the logs.
> 
> I've changed the patch for 2.4.19-pre7 + vm3 + latest rml-O(1) + preempt.

Beats me.  Some of the implementations of page colouring I have seen are
not even SMP-safe.

"Don't do that"

	Robert Love

