Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTFBU3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFBU3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:29:24 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:13065 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262422AbTFBU3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:29:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] epoll race fix for 2.5 ...
Date: Mon, 2 Jun 2003 22:42:22 +0200
User-Agent: KMail/1.5.2
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
References: <Pine.LNX.4.55.0305311458260.11255@bigblue.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.55.0305311458260.11255@bigblue.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306022242.22879.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 22:27, Davide Libenzi wrote:

Hi Davide,

> The was a race triggered by heavy MT usage that could have caused
> processes in D state. Bad Davide, bad ...
> Also, the semaphore is now per-epoll-fd and not global. Plus some comment
> adjustment.
> Updated patches for 2.4.{20,21-rc6} are here :
> http://www.xmailserver.org/linux-patches/nio-improve.html#patches
is it just me or am I too silly to follow your release name changes? ;)

ciao, Marc

