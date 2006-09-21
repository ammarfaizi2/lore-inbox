Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWIUJhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWIUJhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIUJhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:37:52 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:48906 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750713AbWIUJhw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:37:52 -0400
Message-ID: <45125D6D.9080704@argo.co.il>
Date: Thu, 21 Sep 2006 12:37:49 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ben Duncan <ben@versaccounting.com>, linux-kernel@vger.kernel.org
Subject: Re: Request kernel 2.6.18 ..
References: <1158831256.11109.98.camel@localhost.localdomain>
In-Reply-To: <1158831256.11109.98.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 09:37:50.0512 (UTC) FILETIME=[9AC9CB00:01C6DD61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Ar Mer, 2006-09-20 am 19:31 -0500, ysgrifennodd Ben Duncan:
> > Report: 2.6.18 has solved a lot of issues with
> > my 965 chipset Duo Core intel MB and has been
> > extremely stable ...
> >
> > Now, any idea on a timeline for driver for the Marvell IDE
> > controller ?
>
> Possibly never. Marvell don't currently seem to want to play. Now that
> might be for several reasons, one of which is that its someone elses
> chip rebadged. In that case someone has a chance of working out what it
> copies (eg which bits change when you boot with or without a master or
> slave on each channel is a good clue)
>
> The current prognosis however is that you and/or other marvell users are
> going to have to reverse-engineer the thing or just avoid boards using
> that chip.
>

I have such a board, and all-generic-ide appears to work (at least 
enough to load the installer from CD, all the rest is SATA).  Perhaps it 
can be quirked so the parameter won't be necessary?

-- 
error compiling committee.c: too many arguments to function

