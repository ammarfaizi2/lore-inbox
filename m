Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWG1SdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWG1SdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWG1SdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:33:18 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:62950 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1161220AbWG1SdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:33:17 -0400
Message-ID: <44CA586C.4010205@oracle.com>
Date: Fri, 28 Jul 2006 11:33:16 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru> <44C930D5.9020704@oracle.com> <20060728052312.GB11210@2ka.mipt.ru>
In-Reply-To: <20060728052312.GB11210@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I completely agree that existing kevent interface is not the best, so
> I'm opened for any suggestions.
> Should kevent creation/removing/modification be separated too?

Yeah, I think so.

>>> Hmm, it looks like I'm lost here...
>> Yeah, it seems my description might not have sunk in :).  We're giving
>> userspace a way to collect events without performing a system call.
> 
> And why do we want this?

So that event collection can be very efficient.

> How glibc is supposed to determine, that some events already fired and
> such requests will return immediately, or for example how timer events
> will be managed?

...

That was what my previous mail was all about!

- z
