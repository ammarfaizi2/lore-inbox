Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTD3JnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTD3JnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:43:00 -0400
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.90]:51787 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id S262001AbTD3Jm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:42:59 -0400
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: Linux-2.4.20 on a 4 MB Laptop - Kernel bug?
Date: Wed, 30 Apr 2003 11:55:11 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304091601.55821.dusty@violin.dyndns.org> <3E94DCA1.5020106@vgertech.com>
In-Reply-To: <3E94DCA1.5020106@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301155.11319.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 April 2003 04:53, Nuno Silva wrote:
> Hello!
>
> Hermann Himmelbauer wrote:
> > Well - anyway, the kernel boots but right stops after:
> > INIT: Entering runlevel:3
> >
> > The next line is:
> > INIT: open(/dev/console): Input/output error
> > INIT: Id "2" respawning too fast: disabled for 5 minutes
> > ...
> >
> > That's it.
>
> Maybe you striped too much and didn't include *any* console type
> (serial, vga or framebuffer)? :)

Well - by chance we found another old Laptop, an IBM Thinkpad 350 (the old was 
model 340) and found a RAM extension, so we have no 36MB RAM.

But - guess what: The error still persists!

I am quite clueless - maybe it has something to do with the IDE subsystem? We 
put a 4GB 2.5'' HD in this old Laptop, but the harddisk is correctly 
recognized by Linux (also Partition check), grub is also working and it Linux 
also mounts the partition.

Is there any way to get more information out of the kernel?

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

