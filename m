Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUIOQBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUIOQBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUIOQAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:00:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265287AbUIOP6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:58:23 -0400
Message-ID: <41486691.3080202@pobox.com>
Date: Wed, 15 Sep 2004 11:58:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ricky Beam <jfbeam@bluetronic.net>,
       Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
References: <Pine.GSO.4.33.0409151047560.10693-100000@sweetums.bluetronic.net> <1095263296.2406.141.camel@krustophenia.net>
In-Reply-To: <1095263296.2406.141.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-09-15 at 10:55, Ricky Beam wrote:
> 
>>On Wed, 15 Sep 2004, Zilvinas Valinskas wrote:
>>
>>>Perhaps that is mixture of PREEMPT=y and ipsec ? dunno ...
>>
>>No mixture necessary.  PREEMPT is uber-screwed up.  Try rebuilding your
>>kernel/modules with it disabled. (make clean first; the kernel deps don't
>>track CONFIG_PREEMPT correctly.)
> 
> 
> Um, PREEMPT works just fine.  Anything that breaks on PREEMPT will also
> break on SMP.  And the kernel deps do track CONFIG_PREEMPT correctly.


PREEMPT is a hack.  I do not recommend using it on production servers.

	Jeff


