Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVFVW4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFVW4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFVWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:53:34 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:23500 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S262546AbVFVWw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:52:28 -0400
Message-ID: <42B9CFA1.6030702@trex.wsi.edu.pl>
Date: Wed, 22 Jun 2005 22:52:49 +0200
From: =?UTF-8?B?TWljaGHFgiBQaW90cm93c2tp?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
Cc: "LKML <\"\" \">" <"linux-kernel\""@vger.kernel.org>
Subject: Re: Script to help users to report a BUG
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com> <20050622120848.717e2fe2.rdunlap@xenotime.net>
In-Reply-To: <20050622120848.717e2fe2.rdunlap@xenotime.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

randy_dunlap napisał(a):

>On Sun, 19 Jun 2005 22:32:16 +0200 Paolo Ciarrocchi wrote:
>
>| Hi all,
>| what do you think about this simple idea of a script that could help
>| users to fill better BUG reports ?
>| 
>| The usage is quite simple, put the attached file in
>| /usr/src/linux/scripts and then:
>| 
>| [root@frodo scripts]# ./report-bug.sh /tmp/BUGREPORT/
>| cat: /proc/scsi/scsi: No such file or directory
>| 
>| [root@frodo scripts]# ls /tmp/BUGREPORT/
>| cpuinfo.bug  ioports.bug  modules.bug  software.bug
>| iomem.bug    lspci.bug    scsi.bug     version.bug
>| 
>| Now you can simply attach all the .bug files to the bugzilla report or
>| inline them in a email.
>| 
>| The script is rude but it is enough to give you an idea of what I have in mind.
>| 
>| Any comment ?
>
>It can be useful.  We certainly see bug reports with a good bit
>of missing information.
>
>I would rather see the script write all /proc etc. contents to just
>one file (with some headings prior to each file).  One file would be
>easier to email inline or to attach...
>
>---
>~Randy
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
We talk about it (me and Paolo) in private correspondence.

Here is my version:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a5.tar.bz2

Here is my topic on kerneltrap:
http://kerneltrap.org/node/5325

If you have any suggestions, coments, please send me email or post on 
kerneltrap.

Regards,
Michał Piotrowski
