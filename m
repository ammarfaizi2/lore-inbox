Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSEAXqx>; Wed, 1 May 2002 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314132AbSEAXqw>; Wed, 1 May 2002 19:46:52 -0400
Received: from jalon.able.es ([212.97.163.2]:9666 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S314126AbSEAXqv>;
	Wed, 1 May 2002 19:46:51 -0400
Date: Thu, 2 May 2002 01:46:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] intel eths for 2.4 [was: Plan for e100-e1000 in mainline]
Message-ID: <20020501234644.GA1698@werewolf.able.es>
In-Reply-To: <20020501010828.GA1753@werewolf.able.es> <3CCF796C.5090401@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.01 Jeff Garzik wrote:
>J.A. Magallon wrote:
>
>>Hi.
>>
>>Well, subject says it all. Which is the status/plans for inclussion
>>of those drivers in mainline kernel ? AFAIR, e1000 had been licensed,
>>but e100 was not clear yet.
>>
>
>e100 has been in 2.5.x for quite a long time.  All license issues have 
>similarly been resolved a long time ago.
>
>I expect Intel's Q/A to green light their current driver.  With a few 
>patches it should be ready for 2.4.x soon.
>
>You can easily copy drivers/net/e100[0] into a 2.4.x kernel, it likely 
>compiles without modification.
>

I did it, taking drivers from 2.5.12, and at least it compiles.
I have to try in the real box, but I don't think there were any problems,
at least the same than 2.5....

Marcelo, is there any chance to get this in next -pre or in .19 ?
Patches are big, so I put them at:

http://giga.cps.unizar.es/~magallon/linux/kernel/intel/e100-2.0.27-pre3.bz2
http://giga.cps.unizar.es/~magallon/linux/kernel/intel/e1000-4.2.8.bz2

(note, second gives some offsets and a fail if applied without the first
one...)

Some notes/questions:

- e100 has no help text.
- Versions are far newer than those listen in intel web pages:
  * e100: Intel web is 1.8.35, the driver taken from 2.5.12 is 2.0.27-pre3
  * e1000: Intel web is 4.1.7, driver in 2.5 is 4.2.8

Thanks for all the info.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
