Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267798AbUIUPiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbUIUPiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267792AbUIUPiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:38:54 -0400
Received: from mail.aei.ca ([206.123.6.14]:16862 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267760AbUIUPhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:37:14 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
From: Shane Shrybman <shrybman@aei.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921073219.GA10095@elte.hu>
References: <1095714967.3646.14.camel@mars> <20040921073219.GA10095@elte.hu>
Content-Type: text/plain
Message-Id: <1095781027.3612.1.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 11:37:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 03:32, Ingo Molnar wrote:
> * Shane Shrybman <shrybman@aei.ca> wrote:
> 
> > I am having what appears to be IDE DMA problems with 2.6.9-rc2-mm1-S1.
> > 2.6.9-rc2-mm1 does not show this problem and runs fine. Before this I
> > was happily using 2.6.8-rc3-O5.
> > 
> > I tried booting with acpi=off but was unable to enter my user name at
> > the login prompt, it just hung with no response to sysreq. I also
> > tried turning off irq threading for that irq but it made no
> > difference.
> 
> does undoing (patch -R) the attached patch fix this IDE problem?
> 

Yes, backing out that patch seems to have fixed that problem. Thanks.

> 	Ingo

Regards,

Shane

