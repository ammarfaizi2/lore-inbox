Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHMJjJ>; Tue, 13 Aug 2002 05:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHMJjJ>; Tue, 13 Aug 2002 05:39:09 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:6415 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S314278AbSHMJi5>;
	Tue, 13 Aug 2002 05:38:57 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: klibc and logging
Date: Tue, 13 Aug 2002 09:42:31 +0000 (UTC)
Organization: Cistron
Message-ID: <ajaka7$qb6$1@ncc1701.cistron.net>
References: <3D58B14A.5080500@zytor.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1029231751 26982 62.216.29.67 (13 Aug 2002 09:42:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3D58B14A.5080500@zytor.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>However, I'm wondering what to do about logging.  Kernel log messages 
>get stored away until klogd gets started, but early userspace may need 
>some way to log messages -- and syslog is obviously not running.  The 
>easiest way to do this would probably be to be able to write to 
>/proc/kmsg (which probably really should be /dev/kmsg) and push messages 
>onto the kernel's message queue; but we could also have a dedicated 
>location in the initramfs for writing logs, and do it all in userspace. 

/dev/shm/log/ ?

Mike.

