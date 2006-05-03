Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWECSPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWECSPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWECSPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:15:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:61468 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751348AbWECSPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:15:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=G8xTRZDa9wxbWErWfmQZHXiARNRWhl4m0sIUHZmSGg59Bh0d982Mk8gWEGeKcxMV+D+5veWaXUqqR4bcK+w0Zc6y/CJihXDWZLzTqxEA2G/oxmfZzr65IFmPuupj77t1I4CRLQfgFXwDuLk+eB1dgjEX2BK73b2BbNRiIQgDyPU=
Date: Wed, 3 May 2006 20:14:13 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       axboe@suse.de, nickpiggin@yahoo.com.au, pbadari@us.ibm.com,
       arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-Id: <20060503201413.34955426.diegocg@gmail.com>
In-Reply-To: <346638681.24899@ustc.edu.cn>
References: <346556235.24875@ustc.edu.cn>
	<20060502144641.62df9c18.diegocg@gmail.com>
	<346580906.19175@ustc.edu.cn>
	<20060502180753.096f8777.diegocg@gmail.com>
	<346638681.24899@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 3 May 2006 14:45:03 +0800,
Wu Fengguang <wfg@mail.ustc.edu.cn> escribió:

> Lubos Lunak also reminds me of SUSE's preload
> (http://en.opensuse.org/index.php?title=SUPER_preloading_internals)
> which is a user-land solution using strace to collect the info.
> 
> And there's Andrea Arcangeli's "bootcache userspace logging" kernel
> patch(http://lkml.org/lkml/2004/8/6/216).

Just for completeness, windows vista will include a enhanced prefetcher
called (sic) SuperFetch. The idea behind it seems to be to analyze I/O
patterns and then "mirror" the most frequently used disk blocks into
the USB flash drive; so if when the usb flash drive is plugged in
the system will read those blocks from it as it was the hard drive
the next time you run the app
(http://www.windowsitpro.com/Windows/Article/ArticleID/48085/48085.html)

