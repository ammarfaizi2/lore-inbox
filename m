Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319311AbSH2TUs>; Thu, 29 Aug 2002 15:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319309AbSH2TUs>; Thu, 29 Aug 2002 15:20:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12417 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S319311AbSH2TUs>; Thu, 29 Aug 2002 15:20:48 -0400
Date: Thu, 29 Aug 2002 15:28:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Raj, Ashok" <ashok.raj@intel.com>
cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Stack Limit...
In-Reply-To: <8A9A5F4E6576D511B98F00508B68C20A0C84D1CC@orsmsx106.jf.intel.com>
Message-ID: <Pine.LNX.3.95.1020829152355.12530A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Raj, Ashok wrote:

> Hello.
> 
> Please reply to me, since i dont have this email id on the list. 
> 
> Could someone tell me at what the kernel stack size limit is? 
> 

Only two PAGES, 0x1000 per page on a ix86.

> Is there a gcc option for x86 that can warn if too large variables are
> specified in the stack?
> 

sizeof(whatever_local_variable)

> recently we had a problem with one variable accidently declared on the stack
> which was quite large, and when
> some calls nested, we noticed stack corruption. Once the variable was moved
> to global, the corruption went away. We would always see that some member of
>

Yes strange things happen when stack, which goes down, meets data...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

