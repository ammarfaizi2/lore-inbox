Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135632AbRD1VFQ>; Sat, 28 Apr 2001 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbRD1VFH>; Sat, 28 Apr 2001 17:05:07 -0400
Received: from [161.69.248.229] ([161.69.248.229]:41870 "HELO
	mcafee-labs.nai.com") by vger.kernel.org with SMTP
	id <S135632AbRD1VEz>; Sat, 28 Apr 2001 17:04:55 -0400
Message-ID: <XFMail.20010428140614.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010428210013.625F6F6E1@mail.cvsnt.org>
Date: Sat, 28 Apr 2001 14:06:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Tony Hoyle <tmh@nothing-on.tv>
Subject: RE: just-in-time debugging?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-Apr-2001 Tony Hoyle wrote:
> On 28 Apr 2001 13:44:48 -0700, Davide Libenzi wrote:
>> Sorry but why don't You run Your application with gdb ?
>> Once Your program crashes You'll get the prompt and You'll be able to
>> stack-trace and watching whatever You need.
>> The solution I use to be able to get inside the program even when the gdb is
>> not running is the one that You can find in the attached file.
>> Basically it install the handler that will create a script file that You can
>> use to automatically enter with gdb inside Your program while it's running.
> 
> 
> 
> Because the program is invoked as part of a much larger system & I don't
> 
> know which process is going to crash when.  
> 
> Having gdb come up automatically would greatly decrease development
> time.  I'm trying to track down multiple bugs (caused by me, but they
> still need tracking down) which show up during stress testing.  The bug
> will manifest itself in maybe the 1000th iteration...   If I could hack
> gdb into coming up automatically when things went wrong it'd get rid of
> the need to have thousands of printf's in the app (which is my primary
> debugging tool at the moment).
> 
> At work I do this all the time... Windows pops up a dialog which
> basically says 'the program has crashed, debug?' and drops you straight
> into VC with everything intact.  It has assertion macros which wrap int3
> instructions.  You then continue your app under normal debug conditions.

Just check the code I sent, it works fine for Your needs.



- Davide

