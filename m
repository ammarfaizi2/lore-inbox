Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTI2Qmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTI2Qmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:42:45 -0400
Received: from web40906.mail.yahoo.com ([66.218.78.203]:4453 "HELO
	web40906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263715AbTI2Qmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:42:43 -0400
Message-ID: <20030929164242.5518.qmail@web40906.mail.yahoo.com>
Date: Mon, 29 Sep 2003 09:42:42 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: [BUG] Defunct event/0 processes under 2.6.0-test6-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030929094136.0b4bb026.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Morton,

--- Andrew Morton <akpm@osdl.org> wrote:
> Bradley Chapman <kakadu_croc@yahoo.com> wrote:
> >
> > I am experiencing defunct event/0 kernel daemons under 2.6.0-test6-mm1
> >  with synaptics_drv 0.11.7, Dmitry Torokhov's gpm-1.20 with synaptics
> >  support, and XFree86 4.3.0-10. Moving the touchpad in either X or with
> >  gpm causes defunct event/0 processes to be created. 
> 
> Defunct is odd.  Have you run `dmesg' to see if the kernel oopsed?

That was one of the first things I checked. There were no Oopses and nothing
else seemed to suffer, i.e. no high CPU usage or other nasty dmesg messages.

> 
> You could try reverting synaptics-reconnect.patch, and then serio-reconnect.patch
> from
> 
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1/broken-out
> 

OK. I will report back once I have rebooted.

Brad


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
