Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUBWEnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 23:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUBWEnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 23:43:45 -0500
Received: from www1.mail.lycos.com ([209.202.220.140]:57487 "HELO lycos.com")
	by vger.kernel.org with SMTP id S261806AbUBWEno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 23:43:44 -0500
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Date: Mon, 23 Feb 2004 09:43:30 +0500
From: "vishwas manral" <vishwas.manral@lycos.com>
Message-ID: <GEEGLONMDDKOLIAA@mailcity.com>
Mime-Version: 1.0
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
X-Sent-Mail: off
Reply-To: vishwas.manral@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Badness in pci_find_subsys
X-Sender-Ip: 61.95.163.161
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin/Prakash,

I was checking the pci documentation and it said under the heading Obsolete function

pci_find_subsys() - Superseded by pci_get_subsys() as the former is not Hot plug safe.

Could this be related to the problem?

Thanks,
Vishwas

--------- Original Message ---------

DATE: Sun, 22 Feb 2004 18:52:11
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>

>Robin Rosenberg wrote:
>> There is a regular error (2.6.1,2.6.2) that locks up my X although I don't know if it has anything to
>> do with X per se other than that after every lockup i find an error in syslog.
>> 
>> Feb 22 18:23:25 h6n2fls33o811 kernel: Badness in pci_find_subsys at drivers/pci/search.c:167
>> Feb 22 18:23:25 h6n2fls33o811 kernel: Call Trace:
>> Feb 22 18:23:25 h6n2fls33o811 kernel:  [pci_find_subsys+215/224] pci_find_subsys+0xd7/0xe0
>>
>[snip]
>
>It is Nvidia binary driver doing some crap.
>
>Prakash
>


____________________________________________________________
Find what you are looking for with the Lycos Yellow Pages
http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10
