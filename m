Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271269AbTHCS6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271262AbTHCS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:58:15 -0400
Received: from village.ehouse.ru ([193.111.92.18]:31760 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S271269AbTHCS6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:58:12 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm3 and mysql
Date: Sun, 3 Aug 2003 22:58:17 +0400
User-Agent: KMail/1.5
Cc: Shane Shrybman <shrybman@sympatico.ca>, linux-kernel@vger.kernel.org
References: <1059871132.2302.33.camel@mars.goatskin.org> <20030802180410.265dfe40.akpm@osdl.org>
In-Reply-To: <20030802180410.265dfe40.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308032258.17450.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Sunday 03 August 2003 05:04, Andrew Morton wrote:
> Shane Shrybman <shrybman@sympatico.ca> wrote:

<cut>

>
> > One last thing, I have started seeing mysql database corruption
> > recently. I am not sure it is a kernel problem. And I don't know the
> > exact steps to reproduce it, but I think I started seeing it with
> > -test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
> > being playing with mysql/php.
>
> hm, that's a worry.  No additional info available?
>

I also suffer from this problem (I'm speaking about heavy InnoDB corruption
here), but with vanilla 2.6.0-test2. I can't blame MySQL/InnoDB because
there are a lot of MySQL boxes around of me with the same (in fact the box
wich failed is replication slave) or allmost the same database setup.
All other boxes (2.4 kernel) works fine up to now.

Sorry but I can't provide additional info. There was no messages in kernel log.
All I have is mysql error logs. But I'm afraid they are not very helpfull
for kernel developers.
http://sysadminday.org.ru/linux-2.6.0-test2_InnoDB_crash

System is x86 UP PIII 500, 1Gb RAM with software RAID1 over two scsi disks.



-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
