Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWHXFne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWHXFne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 01:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWHXFne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 01:43:34 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:58518 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1030313AbWHXFnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 01:43:33 -0400
Date: Thu, 24 Aug 2006 07:43:30 +0200 (MEST)
From: Mattias Wadenstein <maswan@acc.umu.se>
To: Chris Friesen <cfriesen@nortel.com>
cc: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>, marc@perkel.com
Subject: Re: Linux: Why software RAID?
In-Reply-To: <44ED3723.3090308@nortel.com>
Message-ID: <Pine.GSO.4.64.0608240742000.16414@montezuma.acc.umu.se>
References: <44ED1E41.40606@garzik.org> <44ED3723.3090308@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, Chris Friesen wrote:

> Jeff Garzik wrote:
>
>> But anyway, to help answer the question of hardware vs. software RAID, I 
>> wrote up a page:
>>
>>     http://linux.yyz.us/why-software-raid.html
>
> Just curious...with these guys 
> (http://www.bigfootnetworks.com/KillerOverview.aspx) putting linux on a PCI 
> NIC to allow them to bypass Windows' network stack, has anyone ever 
> considered doing "hardware" raid by using an embedded cpu running linux 
> software RAID, with battery-backed memory?

I'd expect this to be the reason why md offload support to xor engines and 
whatever turns up. It makes very little sense for a modern server/desktop 
CPU, but for the embedded ones it does.

/Mattias Wadenstein
