Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSD2Lhz>; Mon, 29 Apr 2002 07:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315102AbSD2Lhy>; Mon, 29 Apr 2002 07:37:54 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:26100 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315101AbSD2Lhx>; Mon, 29 Apr 2002 07:37:53 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> 
To: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to enable printk 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Apr 2002 12:37:16 +0100
Message-ID: <29915.1020080236@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


wyuan1@ews.uiuc.edu said:
>  It may be a simple question. But I cannot see the result of printk in
> console like the following. Do i need to enable it somewhere? Thanks

You didn't give a priority, so it will have defaulted to KERN_WARNING.

Some distributions disable the logging of KERN_WARNING messages to the 
console, which seems to be a very silly thing to do. I suggest you 
re-enable these messages (echo 7 > /proc/sys/kernel/printk) and file a bug 
report.

--
dwmw2


