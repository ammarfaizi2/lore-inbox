Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131297AbRCOVNQ>; Thu, 15 Mar 2001 16:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCOVNG>; Thu, 15 Mar 2001 16:13:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:8713 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131297AbRCOVMx>;
	Thu, 15 Mar 2001 16:12:53 -0500
Date: Thu, 15 Mar 2001 22:11:55 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Art Boulatov <art@ksu.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root & linuxrc problem
In-Reply-To: <3AB0C09A.1020505@ksu.ru>
Message-ID: <Pine.LNX.4.33.0103152143320.928-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Art Boulatov wrote:

> How can I "exec /sbin/init" from "/linuxrc", whatever it is,
> if "linuxrc" does not get PID=1?
>
> Actually, why does NOT "linuxrc" get PID=1?

That's the question.. the first task started gets pid=1, and when
that is true, exec /sbin/init has no problem.  What else is your
system starting?.. it must be starting something.

	-Mike

