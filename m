Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265944AbUHFNuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUHFNuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUHFNuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:50:40 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:23455 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S265944AbUHFNui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:50:38 -0400
Message-ID: <41138C67.7040306@rtr.ca>
Date: Fri, 06 Aug 2004 09:49:27 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Jakma <paul@clubi.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org> <1091795565.16307.14.camel@localhost.localdomain>
In-Reply-To: <1091795565.16307.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Also, the drive is extremely slow now, about 1MB/s drive transfer 
>>rate as reported by hdparm -T. 
> 
> Sounds like it dropped to PIO - that may be a bug triggered by the drive
> failing.

That should read "hdparm -t", not "-T", right?

And the slowness is most likely due to the error recovery
(retries) in the drive and/or driver, which cause the
overall throughput to plummet for the measurement interval.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
