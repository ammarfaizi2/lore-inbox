Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310681AbSCLLu4>; Tue, 12 Mar 2002 06:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCLLuo>; Tue, 12 Mar 2002 06:50:44 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:40406 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S310656AbSCLLtt>; Tue, 12 Mar 2002 06:49:49 -0500
From: <benh@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Bill Davidsen <davidsen@tmr.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Date: Tue, 12 Mar 2002 01:33:45 +0100
Message-Id: <20020312003345.606@mailhost.mipsys.com>
In-Reply-To: <3C8DE239.2070305@evision-ventures.com>
In-Reply-To: <3C8DE239.2070305@evision-ventures.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Linus, would it be acceptable to you to include an -optional- filter for 
>> ATA commands?  There is definitely a segment of users that would like to 
>> firewall their devices, and I think (as crazy as it may sound) that 
>> notion is a valid one.
>
>If you are *trully paranoid* and want to *fire wall* your device then
>the proper way of doing this is to DISABLE those ioctl entierly.
>It simple like that. They are not required for regular operation by
>concept. Other then this I see no argument here.

Well; I don't agree. Firewall via a loadable module can make sense if the
actual module does a kind of "filter all but a specified known set of safe
commands" for example, like retreiving SMART infos, or such things.

Ben.



