Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265588AbUEZNbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265588AbUEZNbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUEZNbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:31:44 -0400
Received: from tristate.vision.ee ([194.204.30.144]:54677 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265654AbUEZNaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:30:07 -0400
Message-ID: <40B49BD6.7050202@vision.ee>
Date: Wed, 26 May 2004 16:29:58 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.6.x kernel sluggish behavior
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Overall I really like the performance and smoothness of 2.6.x kernels,
but there has been always one problematic situation.

It's debian here with X/KDE running. The problem manifests itself
when one launches acroread-plugin in Mozilla or Mozilla-based browser. 
Whatever
is the reason, but when acroread is launched as browser plugin, it makes
system quite sluggish. X process starts to consume about 70% of cpu time 
continuosly.

That would not be a problem usually, but in this case system really 
feels like hanging
and stopping. Mouse cursor on screen stops and jumps and does other neat 
tricks.
Drawing of pages in acroread is extremely slow. Its very very bad when 
loaded document is some kind
of marketing brochure full of pictures/backgrounds etc... Nothing of 
this when acroread is being run as
standalone app.

Even more. This system has several terminals connected to it, and all of 
them show
same sluggish behavior same time. So it's not like X-server process 
running on system
is too busy to interact with mouse or draw on screen.

This behavior stops when the window with acroread is closed (or back 
button pressed when one
can direct mouse cursor to that button which as you can believe is very 
hard in this case).

I think it's definetely a scheduler problem (although caused by 
application bug).

You propably need more information. Just ask. I'm happy to help to get 
this annoying
problem disappear.

Lenar
