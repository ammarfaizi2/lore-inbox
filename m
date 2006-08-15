Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWHOOjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWHOOjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWHOOjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:39:45 -0400
Received: from rtr.ca ([64.26.128.89]:35256 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030320AbWHOOjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:39:44 -0400
Message-ID: <44E1DCAE.9020803@rtr.ca>
Date: Tue, 15 Aug 2006 10:39:42 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT not active
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr> <1155558984.24077.191.camel@localhost.localdomain>
In-Reply-To: <1155558984.24077.191.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Hyperthreading must be BIOS enabled, its not something Linux can "turn
> on". The "ht" flag merely indicates that the processor supports
> hyperthreading not that it is enabled.

Not quite.  Even non-HT CPUs report the ht flag (I have one here).
As somebody else said, ht just means the system supports querying
the number of ht "siblings", even though that number might be zero.

Somewhat misleading, though technically accurate.

Cheers
