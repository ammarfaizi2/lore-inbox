Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTBKWG7>; Tue, 11 Feb 2003 17:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTBKWG7>; Tue, 11 Feb 2003 17:06:59 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:61396 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S266755AbTBKWG6>; Tue, 11 Feb 2003 17:06:58 -0500
Message-ID: <3E49762E.3030002@bogonomicon.net>
Date: Tue, 11 Feb 2003 16:16:14 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: walt <wa1ter@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4-ac3 hangs at reboot
References: <3E47E257.3000904@hotmail.com> <1044913493.2077.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix in patch-2.4.21-pre4-ac4 looks like it works to remove the 
reboot hang.  I ran it thourgh a few reboots to test.  Thanks.

As a side note I still see the "Rebooting..." message before the md: 
messages.

- Bryan

Alan Cox wrote:
> On Mon, 2003-02-10 at 17:33, walt wrote:
>>Actually this problem started with ac2.  All seems to work well until I
>>reboot the machine with 'shutdown' or 'reboot' or 'ctl-alt-del'.
>>
>>The machine shuts down properly to the point where all filesystems
>>are remounted readonly, which is the point where I normally see an
>>immediate reboot.  Starting with pre4-ac2 I just get an indefinite
>>hang instead of the reboot.



