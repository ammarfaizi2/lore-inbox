Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUIQNaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUIQNaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUIQNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:30:07 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:45321 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S268745AbUIQNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:30:02 -0400
Message-ID: <414AE6DA.3050600@myrealbox.com>
Date: Fri, 17 Sep 2004 06:30:02 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a4) Gecko/20040916
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.9-rc2-bk] Freeze during boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something committed in the last 24 hours is causing my machine
to halt partway thru bootup.  It will print appropriate messages
on the console for USB hotplug events, but networking never
comes up so I can't ping the machine, and the login process
never starts so I can't login and I can't tell what processes
are actually running.

When I boot yesterday's kernel I get error messages saying
that the kernel modules (from today) can't be loaded because
they are in the wrong format.  That's an error I've never seen
before this morning.  The only thing I can think to do is to
recompile with all the drivers compiled into the kernel and
see if I get any error messages (I'm not seeing any errors
now).

Anyone else seeing anything like this?
