Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965089AbVIAM1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbVIAM1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVIAM1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:27:04 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:20109 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S965089AbVIAM1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:27:03 -0400
Date: Thu, 1 Sep 2005 14:26:33 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <20050830145602.GN8515@g5.random>
Message-ID: <Pine.LNX.4.63.0509011424320.3422@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
 <20050830145602.GN8515@g5.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Andrea Arcangeli wrote:

> That would be nice addition IMHO. It'll be more complex since it'll
> involve netconsole dumping and passing the klive session to the kernel
> somehow (userland would be too unreliable to push the oops to the
> server). The worst part is that oops dumping might expose random kernel
> data (it could contain ssh keys as well), so I would either need to
> purify the stack/code/register lines making the oops quite useless, or
> not to show it at all (and only to show the count of the oopses
> publically). A parameter could be used to tell the kernel if the whole
> oops should be sent to the klive server or if only the notification an
> oops should be sent (without sending the payload with potentially
> sensitive data inside).

This could be a config option too: Whether sending payload data or not. 
And people should see a notification that they may expose sensitive data 
when using the report-function.

Sven
