Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284934AbRLKISQ>; Tue, 11 Dec 2001 03:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284927AbRLKISF>; Tue, 11 Dec 2001 03:18:05 -0500
Received: from flrtn-6-m1-236.vnnyca.adelphia.net ([24.55.71.236]:16537 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S284926AbRLKIR6>;
	Tue, 11 Dec 2001 03:17:58 -0500
Message-ID: <3C15C12E.F0DA5159@pobox.com>
Date: Tue, 11 Dec 2001 00:17:50 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gspujar@hss.hns.com
CC: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Subject: Re: software watchdog
In-Reply-To: <65256B1F.002BF453.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gspujar@hss.hns.com wrote:

> Hi all,
>
> I am using software watchdog in my application.  When the watchdog reboots the
> system,
>
> >>>printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n"); prints the message
> on the console.
>
> I put a delay of 5secs with mdelay, and I can see the message on the console.
> I wanted the message as a syslog,
>
> so I added         kern.crit in /etc/syslog.conf file.,
> But I am not getting the above message in the log file.
> Can any one help me with this ????

Send the message to "*" instead of /var/log/messages

That, and/or arrange to do a sync before reboot.

I'm sure there are other ways as well...

cu

jjs

