Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUIOIek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUIOIek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUIOIek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:34:40 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:51663
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S263851AbUIOIdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:33:19 -0400
Message-ID: <4147FE3A.1020504@ppp0.net>
Date: Wed, 15 Sep 2004 10:32:58 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: thockin@hockin.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
References: <20040915011146.GA27782@hockin.org>	<1095214229.20763.6.camel@localhost>	<20040915031706.GA909@hockin.org>	<20040915034229.GA30747@kroah.com>	<20040915044830.GA4919@hockin.org>	<20040915050904.GA682@kroah.com>	<20040915062129.GA9230@hockin.org>	<4147E525.4000405@ppp0.net>	<20040915064735.GA11272@hockin.org>	<4147E649.1060306@ppp0.net>	<20040915065515.GA11587@hockin.org>	<4147F1B4.1060009@ppp0.net> <20040915005613.2a64f536.pj@sgi.com>
In-Reply-To: <20040915005613.2a64f536.pj@sgi.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Jan wrote:
> 
>>Well, time for /sys/devices/memory/memory<n>/. That would perhaps also
>>be suitable for numa which want to know which memory module is near
>>which cpu. 
> 
> 
> Don't we already have something like that.  On an SN2 near me at this
> time, running 2.6.9-rc1-mm4:
> 
> # pwd
> /sys/devices/system/node/node0
> 
> # ls -lt cpu? | cut -c33-
>          0 Sep 15 00:50 cpu0 -> ../../../../devices/system/cpu/cpu0
>          0 Sep 15 00:50 cpu1 -> ../../../../devices/system/cpu/cpu1
> 
> This tells me that CPUs 0 and 1 are on node 0.

And how do you know which memory modules are near cpu0 and 1 ?
Is there already a devices/system/memory/ thing which also gets linked 
from the node0 directory?
(Sorry, no SN2 to check handy ;-) )

Jan

