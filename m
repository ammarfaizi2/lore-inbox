Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269184AbRHTUcJ>; Mon, 20 Aug 2001 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRHTUb7>; Mon, 20 Aug 2001 16:31:59 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:5642 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S269206AbRHTUby>;
	Mon, 20 Aug 2001 16:31:54 -0400
Message-Id: <200108202032.f7KKW7Y41997@aslan.scsiguy.com>
To: A.J.Scott@casdn.neu.edu
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 aic7xxx -- continuous bus resets 
In-Reply-To: Your message of "Mon, 20 Aug 2001 09:41:25 EDT."
             <3B80DB43.13465.5581E4@localhost> 
Date: Mon, 20 Aug 2001 14:32:07 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Downloading now, will try this afternoon and let you know. 
>
>Another person mentioned that there might be an irq routing problem, 
>and using 'noapic' might fix the problem also. The machine has two 
>ioapics, and it is possible to disable one through the bios setup. I 
>have noticed that interrupt routeing is quite different with both 
>ioapics enabled than with just one. 
>
>Is there any benefit to enableing both, and will enableing just one 
>fix the issue?

I don't know the details of the Linux interrupt routing code.  You'd
have to ask those responsible for that portion of Linux's PCI support.
If playing with APIC settings fixes your problems, then we can safely
say that the aic7xxx driver is not at fault.

--
Justin
