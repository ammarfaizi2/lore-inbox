Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSHIUA0>; Fri, 9 Aug 2002 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSHIUA0>; Fri, 9 Aug 2002 16:00:26 -0400
Received: from pop.gmx.de ([213.165.64.20]:35839 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315456AbSHIUAZ> convert rfc822-to-8bit;
	Fri, 9 Aug 2002 16:00:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@gmx.net>
Organization: WOLK - Working Overloaded Linux Kernel
To: Benjamin LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: AIO together with SMPtimers-A0 oops and freezing
Date: Fri, 9 Aug 2002 22:03:00 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       "J.A. Magallon" <jamagallon@able.es>,
       Ruben Puettmann <ruben@puettmann.net>
References: <200208051920.29018.mcp@linux-systeme.de> <20020806223550.GC2733@werewolf.able.es> <20020806191446.E19564@redhat.com>
In-Reply-To: <20020806191446.E19564@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208092158.57656.m.c.p@gmx.net>
X-PRIORITY: 2 (High)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 01:14, Benjamin LaHaise wrote:

Hi Benjamin,

>> Ben, I am using your AIO 20020619 patch + relevant fixes from the AIO 
>> mailinglist together with your patch Ingo, SMPtimers-A0.

> Hmmm, the only problem I can see in the aio code wrt timer usage is 
> the following.  Does this patch make a difference?  If not, I'm guessing 
> that the problem is something in SMPtimers-A0 that aio happens to 
> trigger.  The only timer aio uses is for the timeout when waiting for an 
> event, and the structure for that is put on the stack.
Perfect!! That, really small, patch makes it working perfectly. The system is 
up for some hours now with stress testing Oracle without any oops() or any 
other problem.

Thanks alot Ben! :-)

I'll let you know, after some days of stress testing Oracle, if it still 
works. I expect it will do! :)


-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
