Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030667AbWJKHG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030667AbWJKHG6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbWJKHG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:06:58 -0400
Received: from gw.goop.org ([64.81.55.164]:59835 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030667AbWJKHG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:06:57 -0400
Message-ID: <452C9819.80400@goop.org>
Date: Wed, 11 Oct 2006 00:07:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
References: <452C3CA6.2060403@goop.org> <1160550147.3000.349.camel@laptopd505.fenrus.org>
In-Reply-To: <1160550147.3000.349.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-10-10 at 17:36 -0700, Jeremy Fitzhardinge wrote:
>   
>> Export jiffies_to_timespec; previously modules used the inlined header version.
>>     
>
> any chance you'll tell us which modules? :)
>   

Out of tree in this case: the madwifi Atheros wireless driver.

    J
