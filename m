Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUELHDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUELHDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 03:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264988AbUELHDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 03:03:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:31505 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264815AbUELHDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 03:03:01 -0400
Message-ID: <40A1CC90.3040609@aitel.hist.no>
Date: Wed, 12 May 2004 09:04:48 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nelis@brabys.co.za
CC: linux-kernel@vger.kernel.org
Subject: Re: weird clock problem
References: <1084282171.8334.46.camel@nelis.brabys.co.za>
In-Reply-To: <1084282171.8334.46.camel@nelis.brabys.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nelis Lamprecht wrote:

>Hi,
>
>Over the past few weeks I've been having major problems keeping time on
>my machine with kernel 2.6.5. At first I thought it was a problem with
>ntpd but as it turns out it's my kernel.
>
>The problem became evident while copying vast amounts of data across to
>my machine. While I was copying data to it via scp my random
>Xscreensaver kicked in displaying the clock and the first thing I
>noticed was that the clock was advancing at a rapid rate. At the same
>time I could not type anything as it would just repeat everything I
>typed 10 fold. Basically the whole system behaved like it was on
>steroids while I was copying to it and by the time I had finished
>copying the clock was 2hrs ahead of time.
>
Take a look at /proc/interrupts. Is the timer interrupt
shared with something?

Helge Hafting
