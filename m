Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161188AbWJKTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161188AbWJKTsK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161189AbWJKTsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:48:10 -0400
Received: from gw.goop.org ([64.81.55.164]:65497 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161188AbWJKTsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:48:08 -0400
Message-ID: <452D4A7E.20709@goop.org>
Date: Wed, 11 Oct 2006 12:48:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
References: <452C3CA6.2060403@goop.org> <20061011161628.GA1873@infradead.org>
In-Reply-To: <20061011161628.GA1873@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Oct 10, 2006 at 05:36:54PM -0700, Jeremy Fitzhardinge wrote:
>   
>> Export jiffies_to_timespec; previously modules used the inlined header 
>> version.
>>     
>
> NACK, drivers shouldn know about these timekeeping details and no
> in-tree driver uses it (fortunately)
>   

timespec_to_jiffies *is* exported, so it would seem to be a symmetry 
issue if nothing else.

    J

