Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTIQT5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTIQT5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:57:48 -0400
Received: from mail.broadpark.no ([217.13.4.2]:17808 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262811AbTIQT5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:57:46 -0400
Date: Wed, 17 Sep 2003 22:00:21 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Changes in siimage driver?
References: <oprvnjyf2oq1sf88@mail.broadpark.no> <1063816835.12648.90.camel@dhcp23.swansea.linux.org.uk> <oprvnqkoo5q1sf88@mail.broadpark.no> <200309172109.54450.bzolnier@elka.pw.edu.pl>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <oprvntuvtkq1sf88@mail.broadpark.no>
In-Reply-To: <200309172109.54450.bzolnier@elka.pw.edu.pl>
User-Agent: Opera7.20/Linux M2 build 463
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 21:09:54 +0200, Bartlomiej Zolnierkiewicz 
<B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>> Well, I understand that, but the older version of the driver (as of
>> test4-mm4) doesn't have these problems (better performance according to
>> hdparm, no corruption). The latest changes to the driver seems to have
>> introduced problems, or is it just me?
>
> You are the first person reporting problems after syncing siimage driver 
> with
> 2.4.x ;-).  It's unlikely that corruption is caused by siimage driver 
> update,
> we should have seen similar problems with 2.4.x, but...
Yes, it's weird, but it happened the first time I tried the test5 kernel. 
Not a good feeling, sitting with directories you can't even delete :\ The 
computer had been up for some time (12 hours or so), and several files I 
had open for editing were zeroed out when I opened them after reboot. 
Could it have to do with my Maxtor DiamondMax drive perhaps? I guess most 
people got Seagate SATA drives, I've since then purchased a Seagate 7200.7 
SATA to complement the Maxtor.

> Performance is crippled because of workaround for buggy controllers.
> We turn it on unconditionally now, we should do it only on affected
> controllers.  I believe freebsd's workaround is correct and we can adopt 
> it.
> For more details please see the other thread regarding siimage.
Sounds great, I think I will migrate to a newer kernel once I have done 
some proper backups to an unmounted partition :]

Thanks

Arve Knudsen
