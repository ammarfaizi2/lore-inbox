Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSAKC6i>; Thu, 10 Jan 2002 21:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289843AbSAKC62>; Thu, 10 Jan 2002 21:58:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:26381 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289842AbSAKC6T>;
	Thu, 10 Jan 2002 21:58:19 -0500
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Ed Tomlinson <tomlins@cam.org>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201101841430.1493-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201101841430.1493-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 22:00:16 -0500
Message-Id: <1010718017.1027.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 21:42, Davide Libenzi wrote:

> Look in init/main.c, if kernel_thread() is called before init_idle().

init is started via kernel_thread prior to init_idle ...

	Robert Love

