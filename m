Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUF3N7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUF3N7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF3N7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:59:16 -0400
Received: from web41115.mail.yahoo.com ([66.218.93.31]:40028 "HELO
	web41115.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265163AbUF3N7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:59:14 -0400
Message-ID: <20040630135907.98538.qmail@web41115.mail.yahoo.com>
Date: Wed, 30 Jun 2004 06:59:07 -0700 (PDT)
From: tom st denis <tomstdenis@yahoo.com>
Subject: Re: 2.4.26: IDE drives become unavailable randomly
To: linux-kernel@vger.kernel.org
Cc: Andre Costa <costa@tecgraf.puc-rio.br>
In-Reply-To: <20040630084142.10a3598b.costa@tecgraf.puc-rio.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andre Costa <costa@tecgraf.puc-rio.br> wrote:
> (please cc me on any replies, because I am not subscribed to this
> list;
> if I do need to subscribe, just let me know)
> 
> Hi,
> 
> I am using 2.4.26 SMP on a ABIT AT7 mobo, with a 2.8GHz P4 processor
> with hyper-threading enabled. I have one 80GB Seagate IDE disk
> as /dev/hda, and from time to time it seems to "disappear", usually
> after these messages appear a couple of trimes on/var/log/messages:

I get a similar problem on my Presario laptop.  In my case "all of a
suddend" hda3 becomes write-only.  Next time it happens I'll see if I
can capture a dmesg log or something.  It only seems to happen when I
enable my wifi and do a lot of disk activity [but only once in a
while].  Could be that my wifi and IDE0 share an IRQ?

Of course I'm more apt to blame my laptop than Linux since the same
kernel [well diff build options but you know what I mean] works just
fine on my two desktops in the house...

Tom



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
