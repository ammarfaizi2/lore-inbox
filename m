Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWHORny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWHORny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWHORnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:43:53 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:41240 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1030398AbWHORnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:43:52 -0400
Date: Tue, 15 Aug 2006 12:43:38 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, Roger Heflin <rheflin@atipa.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: What determines which interrupts are shared under Linux?
Message-ID: <20060815174338.GR7189@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <44E1D760.6070600@atipa.com> <20060815173116.GQ7189@hygelac> <44E20799.4060606@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E20799.4060606@ru.mvista.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.15-1-486 
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 15 Aug 2006 17:43:43.0498 (UTC) FILETIME=[5A09AEA0:01C6C092]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:42:49PM +0400, sshtylyov@ru.mvista.com wrote:
> Hello.
> 
> Terence Ripperda wrote:
> >we've seen a lot of problems on ck804 chipsets when multiple devices
> >share level-triggered interrupts. I think some of the earlier sample
> >bioses assumed that interrupts would be configured via ACPI, and when
> >ACPI is not used, the interrupts end up as level-triggered instead of
> >edge-triggered.
> 
>    Edge-triggered *shared* interrupts?! Now that sounds interesting (I'm 
>    not saying impossible).

ah shoot, you're right. doing too much and got the two backwards.
ignore my email, I'm going off to sit in the corner with a dunce cap
on..

> 
> WBR, Sergei

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
