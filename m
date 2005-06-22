Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVFVTJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVFVTJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVFVTJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:09:09 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:3310 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261570AbVFVTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:08:52 -0400
Date: Wed, 22 Jun 2005 12:08:48 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Script to help users to report a BUG
Message-Id: <20050622120848.717e2fe2.rdunlap@xenotime.net>
In-Reply-To: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2005 22:32:16 +0200 Paolo Ciarrocchi wrote:

| Hi all,
| what do you think about this simple idea of a script that could help
| users to fill better BUG reports ?
| 
| The usage is quite simple, put the attached file in
| /usr/src/linux/scripts and then:
| 
| [root@frodo scripts]# ./report-bug.sh /tmp/BUGREPORT/
| cat: /proc/scsi/scsi: No such file or directory
| 
| [root@frodo scripts]# ls /tmp/BUGREPORT/
| cpuinfo.bug  ioports.bug  modules.bug  software.bug
| iomem.bug    lspci.bug    scsi.bug     version.bug
| 
| Now you can simply attach all the .bug files to the bugzilla report or
| inline them in a email.
| 
| The script is rude but it is enough to give you an idea of what I have in mind.
| 
| Any comment ?

It can be useful.  We certainly see bug reports with a good bit
of missing information.

I would rather see the script write all /proc etc. contents to just
one file (with some headings prior to each file).  One file would be
easier to email inline or to attach...

---
~Randy
