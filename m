Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUAPHs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 02:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUAPHs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 02:48:29 -0500
Received: from dmz01.zas.gwz-berlin.de ([195.37.93.3]:39696 "HELO
	dmz01.zas.gwz-berlin.de") by vger.kernel.org with SMTP
	id S265319AbUAPHsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 02:48:22 -0500
Message-ID: <4007973F.3000902@zas.gwz-berlin.de>
Date: Fri, 16 Jan 2004 08:48:15 +0100
From: Axel Beier <axel@zas.gwz-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-DE; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Bradford <john@grabjohn.com>
Subject: Re: nfs version 2 access and kernel 2.6.x freeze
References: <40068F6E.9060901@zas.gwz-berlin.de> <200401151313.i0FDDt1G000475@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401151313.i0FDDt1G000475@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,
no success. Tested with 2.6.1-mm3 and pre-emption off. System freezes 
after 10-20 seconds during reading data from the nfs-server.

Axel

John Bradford schrieb:
> Quote from Axel Beier <axel@zas.gwz-berlin.de>:
> 
>>after upgrading to kernel 2.6.0 on client-side i cannot copy data from 
>>my (old) nfs server. The server is old (running SuSE 7.1 with a 2.4.19 
>>kernel) and supports only nfs version 2.
>>But with kernels 2.6.0 upto 2.6.1-mm2 after few seconds of copying a 
>>remote-file to the client the client hangs completely.
>>Kernel was compiled with gcc 3.3.1 and has preemptive enable.
> 
> 
> Try disabling pre-emption.  It is known to make some hard to trigger
> bugs happen much more frequently.  If this appears to fix it, please
> let us know.
> 
> John.
> 
> 
