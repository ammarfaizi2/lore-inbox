Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWDMOMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWDMOMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWDMOMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:12:54 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:45407 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964943AbWDMOMy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:12:54 -0400
Message-ID: <b29067a0604130712r275c3f0bndd1cc928415b3255@mail.gmail.com>
Date: Thu, 13 Apr 2006 10:12:53 -0400
From: "Rahul Karnik" <rahul@genebrew.com>
To: "Leonid Kalev" <lion@odcnet.com>
Subject: Re: Tracking down leaking applications
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <4439FD3A.9060305@odcnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b29067a0604090842h3bb11a88re9c175a467763c9f@mail.gmail.com>
	 <4439FD3A.9060305@odcnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/06, Leonid Kalev <lion@odcnet.com> wrote:
> This seems a bit off-topic for LKML, because you should *always* check
> user-space for memory leaks before blaming the kernel. A few things that
> can help you with your questions:

Not blaming the kernel yet, just wondering if it can help me track
down the offending app.

> - the 'ps' utility, to see who eats the memory

Well, httpd is at the top of the list, as it should be. What I cannot
tell is if the processes are leaking memory, or if all is well.

> - valgrind - an excellent tool for tracking down memory leaks (and other
> bugs, too). Comes with Fedora, but check the Web for a newer version.

I will try valgrind on the web application.

Thanks for the help!

-Rahul
--
Rahul Karnik
rahul@genebrew.com
