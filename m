Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUHWREa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUHWREa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHWREa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:04:30 -0400
Received: from mail.imr-net.com ([65.182.241.242]:8105 "EHLO
	commie.imr-net.com") by vger.kernel.org with ESMTP id S265521AbUHWRE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:04:26 -0400
Message-ID: <412A2398.8050702@asylumwear.com>
Date: Mon, 23 Aug 2004 10:04:24 -0700
From: Joshua Schmidlkofer <menion@asylumwear.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
References: <412880BF.6050503@kolivas.org>
In-Reply-To: <412880BF.6050503@kolivas.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what or why, but I am experiancing a nightmare with 
interactivity and heavy nfs use.   I am using Gentoo, and I have my 
portage tree exported from a central server.   Trying to do an emerge 
update world is taking forever.

During the time it is scanning the portage tree it takes 2 - 3 minutes 
to load Firefox.   It also took almost 5 minuts to load GAIM.  Once GAIM 
loaded, none of the screens would paint.  I halted the emerge and 
instantly Gaim painted and all the web pages I was waiting for in 
firefox finished.   So I unleashed emerge again, and tried to load more 
local-only apps.  Same problem.  Horrible delays. Halt emerge, and boom, 
everything snappy and fast.

So, as long as I don't use NFS, this is spectacular, but NFS access is 
murdering me.

In any case, I would take from recommendations.  For testing, etc.  I am 
on the list, but if there is testing, please CC my address.

CPU: Pentium 4 - 1.7Ghz.


memory - [swap usage is already much improved]:
             total       used       free     shared    buffers     cached
Mem:        775200     499796     275404          0       5200     126816
-/+ buffers/cache:     367780     407420
Swap:       799992          0     799992


Root:
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2              39G   26G   13G  67% /
