Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319282AbSH2TDE>; Thu, 29 Aug 2002 15:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319294AbSH2TDE>; Thu, 29 Aug 2002 15:03:04 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:12281 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S319282AbSH2TDD>; Thu, 29 Aug 2002 15:03:03 -0400
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A0C84D1CC@orsmsx106.jf.intel.com>
From: "Raj, Ashok" <ashok.raj@intel.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Kernel Stack Limit...
Date: Thu, 29 Aug 2002 12:07:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Please reply to me, since i dont have this email id on the list. 

Could someone tell me at what the kernel stack size limit is? 

Is there a gcc option for x86 that can warn if too large variables are
specified in the stack?

recently we had a problem with one variable accidently declared on the stack
which was quite large, and when
some calls nested, we noticed stack corruption. Once the variable was moved
to global, the corruption went away. We would always see that some member of

"current" would be corrupted, so when the user mode program exits, we will
notice the files member would be having garbage values.

if there is a compiler option to force that during compilation to point out
such weirdness, or if a runtime check could be done during each function
exit, 
it would be really useful.

thanks
ashokr
