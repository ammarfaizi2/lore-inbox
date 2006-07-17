Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWGQS27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWGQS27 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGQS26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:28:58 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:13780 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751137AbWGQS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:28:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SIb8LHnBKHvvGfqPbqSEMWm25rUoy8w56EezMpO5FxwE4H5LsZKU5wQVgxnDvmBRJ24ao75y6/8ic2Xp3pUxGPYFIfenvOlWIzTq1gIXvnGDvo4s5IFkM8nEqBKoywIcNXrs0QKReoIlqpyk/RWcjCo9i4KHXUrK+VYfMPSgRig=
Message-ID: <6bffcb0e0607171128q21f44912je089d9adb488cd52@mail.gmail.com>
Date: Mon, 17 Jul 2006 20:28:57 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andreas Rieke" <andreas.rieke@isl.de>
Subject: Re: Kernel memory leak?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44BBC09D.5060409@isl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BBC09D.5060409@isl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 17/07/06, Andreas Rieke <andreas.rieke@isl.de> wrote:
> Hi,
>
> after booting a machine, it runs well using about 300 M of 1 G physical
> RAM. However, the remaining RAM decreases day by day, and after 2 or 3
> weeks, the machine crashes because swapping takes too much time.
> However, all processes together take about 250 MBytes according to ps,
> thus I assume that the kernel takes the rest. free tells me in fact that
> much swap space is used an nearly no physical RAM is left.
>
> This behaviour has been seen on Red Hat Enterprise Linux 3 with a 2.4
> kernel and on SuSE Linux 10 with a 2.6.13-15-default kernel. There are
> no unusual things running on the machine, the main application is an
> apache web server with a PostgreSQL database.
>
> Is there any kernel support to detect where the memory has gone?

Yes, the kmemleak patches http://homepage.ntlworld.com/cmarinas/kmemleak/

> Is any kind of memory eating virus or worm known?
> Is it possible that processes request memory which is NOT considered in
> /proc or in the procps tools?
> Is it possible that processes are invisible in /proc or in the procps tools?

Yes - if you have a rootkit.

>
> Thanks in advance,
>
> Andreas

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
