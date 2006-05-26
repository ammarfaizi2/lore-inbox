Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWEZIzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWEZIzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEZIzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:55:24 -0400
Received: from corky.net ([212.150.53.130]:25536 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S1751191AbWEZIzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:55:23 -0400
Message-ID: <4476D019.6090601@corky.net>
Date: Fri, 26 May 2006 10:53:29 +0100
From: Just Marc <marc@corky.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>If the developers of that program want to squeeze the last 5% out of it
>then sure, I'd expect them to use such OS-provided I/O scheduling
>facilities.  Database developers do that sort of thing all the time.
>
>We have an application which knows what it's doing sending IO requests to
>the kernel which must then try to reverse engineer what the application is
>doing via this rather inappropriate communication channel.
>
>Is that dumb, or what?
>
> Given that the application already knows what it's doing, it's in a much
>better position to issue the anticipatory IO requests than is the kernel.

What about a performance driven application (A web server) that's using say
sendfile() in order to reduce the overhead of context switching, how would
this application do its own read-ahead "management" effectively?

Thanks

