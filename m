Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWHHPi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWHHPi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWHHPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:38:58 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:33953 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964965AbWHHPi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:38:58 -0400
Message-ID: <44D8B048.8060103@sw.ru>
Date: Tue, 08 Aug 2006 19:39:52 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Muli Ben-Yehuda <muli@il.ibm.com>,
       =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net>	 <20060808143937.GA3953@rhun.haifa.ibm.com>	 <20060808145138.GA2720@atjola.homenet>	 <20060808145709.GB3953@rhun.haifa.ibm.com> <1155050547.5729.91.camel@localhost.localdomain>
In-Reply-To: <1155050547.5729.91.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Even without getting into just how ugly this is, is it really worth
>>it?
it is impossible to run debug kernels w/o this patch :/
or are you asking whether this optimization worth it?

What makes me worry is that this is a sign that vendors
don't even bother to run debug kernels :((((

> It never was in my opinion but I lost that battle to Linus in 1.3.40 or
> so timescales. Given how critical getppid _isnt_ I don't see the point
> in being clever.
Alan, if you sign off the patch I will prepare another one, which removes
the optimization away and make it always safe.

Kirill

