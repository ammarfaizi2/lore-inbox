Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTEEJYC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTEEJYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:24:01 -0400
Received: from lily.comarch.pl ([195.116.193.4]:2576 "EHLO lily.comarch.pl")
	by vger.kernel.org with ESMTP id S262118AbTEEJX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:23:56 -0400
Message-ID: <005001c312e9$b6000380$d805840a@nbsobczak>
From: "Wojciech Sobczak" <Wojciech.Sobczak@comarch.pl>
To: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
References: <01d601c30f17$f3ffadf0$b312840a@nbsobczak> <3270000.1051712524@[10.10.2.4]> <021501c30f27$e02be4a0$b312840a@nbsobczak> <4360000.1051715907@[10.10.2.4]>
Subject: Re: IBM x440 problems on 2.4.20 to 2.4.20-rc1-ac3
Date: Mon, 5 May 2003 11:35:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>> SuSE works well, at least the SLES edition does.
>>
>> but shoudn't it be platform independent? this is only kernel or
>> meaby i need new gcc... or meaby something else?....
>
> You need the kernel itself. It's the apic handling that's mostly
> different.

ok, thanks to all folks for help,
i'm now using 2.5.68 with linux-isp patch for qlogic support, system is
working nice, i see all 8 processors but cpuinfo shows only 199 bogomips,
but system performance is much much higher :), so meaby this is some kind of
not important bug.
as for now i will try to swich to 2.4.21-rc1 as Keith Mannthey gave me
working kernel config for 2.4

so now  i've got one of them (servers) for kernel testing :)

from the battle field - i tryied to run on 2.5.68-mm3 tree but system hangs
on processors recognition.

as for qlogic support with linux-isp - is this driver with failover support?

regards
WS

