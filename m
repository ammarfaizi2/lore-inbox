Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTI3QGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTI3QGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:06:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:4287 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261546AbTI3QGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:06:34 -0400
From: Vitaly Fertman <vitaly@namesys.com>
Organization: NAMESYS
To: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
Date: Tue, 30 Sep 2003 20:06:32 +0400
User-Agent: KMail/1.5.1
References: <1064936688.4222.14.camel@localhost.localdomain>
In-Reply-To: <1064936688.4222.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302006.32584.vitaly@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

On Tuesday 30 September 2003 19:44, Zan Lynx wrote:
> I was interested in the contents of the files in /proc/fs/reiserfs/sda1,
> so I did these commands:
>
> cd /proc/fs/reiserfs/sda1
> grep . *
>
> (I like using the grep . * because it labels the contents of each file
> with the filename.)
>
> I did this as a regular user and also as root.  Both times the system
> crashed and immediately rebooted.  I tried it again as root and the
> system froze instead.

which kernel do you use? some patches? could you look into syslog and
send us all relevant information.

would you also run cat on all files there separately to detect the fault one.

> The system is basically RedHat 9.  The kernel was compiled with GCC
> 3.2.2.  I attached a compressed lsmod and kernel configuration to this
> message.

no you do not.

> The CPU is an Athlon XP 2000+, the SCSI adapter is a LSI Logic 53c1010
> Ultra3 64 bit adapter running on a 32 bit bus.  (lspci output is also
> attached.)  The SCSI drive is a Seagate X15.3.
>
> Thanks for looking at this.

-- 
Thanks,
Vitaly Fertman
