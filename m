Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTDVWuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTDVWuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:50:44 -0400
Received: from x101-201-233-dhcp.reshalls.umn.edu ([128.101.201.233]:27842
	"EHLO minerva") by vger.kernel.org with ESMTP id S263902AbTDVWum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:50:42 -0400
Date: Tue, 22 Apr 2003 18:02:46 -0500
From: Matt Reppert <arashi@yomerashi.yi.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 state of matroxfb
Message-Id: <20030422180246.0d5bc261.arashi@yomerashi.yi.org>
In-Reply-To: <3EA5ABAE.1020009@wmich.edu>
References: <3EA5ABAE.1020009@wmich.edu>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003 16:53:02 -0400
Ed Sweetman <ed.sweetman@wmich.edu> wrote:

> I'm just wondering what the state of the matroxfb driver is and why it's 
> an option in the kernel when it's completely uncompilable and has been 
> for many months.

Easy. A lot of FB stuff has been nonworking at various stages, since the
whole console layer has been more or less rewritten over the course of 2.5.
(Of course, a lot of kernel internals have changed, so entire *CPU architectures*
have been uncompilable for significant periods of time.)

> I know it requires patches to work and i was under the 
> assumption that these patches were at linux-fbdev.org but that site has 
> been down for the past few days i've tried to access it and with no 
> documentation updates about the new matroxfb driver since 2.4, I've been 
> unable to verify if this is the only place to find the matroxfb patches. 

A search of message archives via groups.google.com yields this site quite
quickly:
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest

Please also read this message from two days ago:
http://groups.google.com/groups?q=matroxfb+group:fa.linux.kernel&hl=en&lr=&ie=UTF-8&as_drrb=b&as_mind=12&as_minm=9&as_miny=2002&as_maxd=22&as_maxm=4&as_maxy=2003&selm=fa.eu6ulqe.4l2eo4%40ifi.uio.no&rnum=6

>   So what i'm getting at is why is there a matroxfb option in the 
> current kernel when the driver isn't there and what the future/current 
> situation is with the framebuffer driver.

Because, it seems, support is planned but there hasn't been time to get all the
issues hammered out. (A lot of kernel devs still are volunteers that have to do
this in whatever free time they have, between actual jobs or, sometimes more
importantly, between searching for jobs, so things don't always happen instantly.)

You might be able to get a feel for the future/current situation of the fb
code if you had a read through your favorite lkml archive, if you're not
subscribed. It looks like the questions or doubts you bring up in this mail
would be answered by doing so.

Matt
