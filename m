Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWIEQwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWIEQwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWIEQwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:52:11 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:12988 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030190AbWIEQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:52:09 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Wed, 06 Sep 2006 02:51:56 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <b9arf2lrbh5v4pv9klbtujfhvq3hiuehdk@4ax.com>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com> <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr> <44FD7B1E.7020102@aitel.hist.no> <1157467176.9018.48.camel@localhost.localdomain>
In-Reply-To: <1157467176.9018.48.camel@localhost.localdomain>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2006 15:39:36 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>Ar Maw, 2006-09-05 am 15:26 +0200, ysgrifennodd Helge Hafting:
>> between sda/hda unless they also use an initrd.  The kernel
>> itself does not seem to support partition by label. :-(
>
>This is correct and one reason vendor kernels generally use an initrd.
>The kernel does however support "root=/dev/sda1"

Which leads back to this slackware user, who's never used an initrd, 
thinking about dual root partitions just to get the name change from 
another /etc/fstab?  

I dual boot 2.4 / 2.6 kernels, looking for a simple solution so I can 
test Alan's work.  

No udev, no initrd, funny I see a second '/' partition as 'easy'? ;)

I'm missing something here?  Generally /etc/lilo.conf looks like:
  <http://bugsplatter.mine.nu/test/boxen/deltree/lilo.conf>

Grant.
