Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSIXU2z>; Tue, 24 Sep 2002 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbSIXU2z>; Tue, 24 Sep 2002 16:28:55 -0400
Received: from mail.webmaster.com ([216.152.64.131]:43651 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261782AbSIXU2z> convert rfc822-to-8bit; Tue, 24 Sep 2002 16:28:55 -0400
From: David Schwartz <davids@webmaster.com>
To: <adi@hexapodia.org>, Ingo Molnar <mingo@elte.hu>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1055) - Licensed Version
Date: Tue, 24 Sep 2002 13:34:01 -0700
In-Reply-To: <20020923190306.D13340@hexapodia.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020924203408.AAA16913@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Sep 2002 19:03:06 -0500, Andy Isaacson wrote:

>Of course this can be (and frequently is) implemented such that there is
>not one Pthreads thread per object; given simulation environments with 1
>million objects, and the current crappy state of Pthreads
>implementations, the researchers have no choice.

	It may well be handy to have a threads implementation that makes these kinds 
of programs easy to write, but an OS's preferred pthreads is not and should 
not be that threads implementation. A platforms default/preferred pthreads 
implementation should be one that allows well-designed, high-performance 
I/O-intensive and compute-intensive tasks to run extremely well.

	DS


