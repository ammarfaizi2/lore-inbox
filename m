Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268449AbUIBQGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268449AbUIBQGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbUIBQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:06:00 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:10368 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S268449AbUIBQFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:05:47 -0400
Message-ID: <4137447E.9000708@rtr.ca>
Date: Thu, 02 Sep 2004 12:04:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@milosz.na.pl, Lee Revell <rlrevell@joe-job.com>,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>	 <200408272005.08407.bzolnier@elka.pw.edu.pl>	 <1093630121.837.39.camel@krustophenia.net>	 <200408272059.51779.bzolnier@elka.pw.edu.pl>  <4135CC9E.5060905@rtr.ca> <1094051215.2777.15.camel@localhost.localdomain>
In-Reply-To: <1094051215.2777.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that  >256 sectors will be a win, worth the
extra overhead because it will save subsequent overheads
of extra commands.

Which is why my original text (quoted by Alan) said:

On Mer, 2004-09-01 at 14:20, Mark Lord wrote:

 >> LBA48 is only needed when (1) the sector count is greater than 256,
 >> and/or (2) the ending sector number >= (1<<28).


Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
