Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWIMUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWIMUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIMUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 16:02:27 -0400
Received: from gw.goop.org ([64.81.55.164]:22954 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751158AbWIMUC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 16:02:26 -0400
Message-ID: <450863CA.3000005@goop.org>
Date: Wed, 13 Sep 2006 13:02:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
References: <450854F3.20603@goop.org>	 <1158175001.3054.7.camel@laptopd505.fenrus.org> <1158177647.16902.2.camel@localhost.localdomain>
In-Reply-To: <1158177647.16902.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-09-13 am 21:16 +0200, ysgrifennodd Arjan van de Ven:
>   
>> I don't know the exact details on these; I do know that several GDT
>> entries tend to be used by BIOSes in their APM implementations and thus
>> are better of not being used.
>>     
>
> Thats 0x40 which tends to get used as if was a real mode base for BIOS
> accesses even via the protected mode interface.
>   

Do you mean descriptor entry 8?  Because that's TLS #3, not reserved...

    J
