Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750715AbWFEQpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFEQpm (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWFEQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:45:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:158 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750715AbWFEQpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:45:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HpBBcACN/JgcDgcS0jS9k3kbwZsCJJdE1zvpcLrAdySFJ/RsDpqqzSZJcKInDFwmERxDhQNJuQosDVKeMG7BPRoS40a/R8RMsCxDhULTgafxYqrQiaMMW0Fu0SUFUa91udRyau1nXF1e6dO89XI3HXOclEvmX3tQzgz8fxHA4Sk=
Message-ID: <986ed62e0606050945k45f35c9fm663d218504789a3a@mail.gmail.com>
Date: Mon, 5 Jun 2006 09:45:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <200606051756.19715.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <200606051756.19715.rjw@sisk.pl>
X-Google-Sender-Auth: cecda5a586a62520
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 05 June 2006 07:23, Barry K. Nathan wrote:
[snip]
> > The messages definitely happen while resuming. My screen is blank
> > during suspend-to-disk so I have no way to know what's going on
> > then...
>
> Please try doing "echo 8 > /proc/sys/kernel/printk" before suspend.

Let me clarify that: During suspend, my monitor does not get any
signal so it shuts itself off.

I should mention, I've never seen that happen during swsusp on any
distribution other than Ubuntu... but that happens to be what I'm
running on this box right now. :/
-- 
-Barry K. Nathan <barryn@pobox.com>
