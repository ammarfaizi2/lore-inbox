Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUDIWUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbUDIWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 18:20:46 -0400
Received: from opersys.com ([64.40.108.71]:14093 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261942AbUDIWUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 18:20:40 -0400
Message-ID: <40772318.8090901@opersys.com>
Date: Fri, 09 Apr 2004 18:26:32 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Announce RTAI 3.1-test1 (RTAI for Linux 2.6)]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those who are interested:

-------- Original Message --------
From: Paolo Mantegazza <mantegazza@aero.polimi.it>
Subject: Announce RTAI 3.1-test1 (RTAI for Linux 2.6)
Date: Fri, 09 Apr 2004 19:56:09 -0700

Ciao,

Philippe did it, likely the first real time Linux-2.6.

So at the RTAI home site: http://www.aero.polimi.it/~rtai/, you'll find
rtai-3.1-test1 for both Linux 2.4.xx and 2.6.x.

 From the content point of view it is what you'll find in 3.0r3, with
some glitches discovered in between ironed off. There is a very
important and significant change however: the death of the RTHAL way of
working for ix86 machines. That alone sets a milestone in RTAI life.
So RTAI i386 will work just on ADEOS and nothing else.

It should be remarked once more that RTAI is 4 things now (in
alphbetical order): FUSION/RTAI/RTAILab/XENOMAI.

A particular note should be reserved to FUSION and I hope that Philippe
will find time to advertise it a bit more in the near future. With
FUSION RTAI has an almost continuous grading of real time requirements:
soft (standard Linux), firm (Linux low latency), hard-1 FUSION, hard-2
LXRT, hard-3 kernel. In my opinion it is likely that a well matured
FUSION will become a key player for many users.

BTW, do not activate the low latency option in Linux 2.6 for a while
more. It is also likely you'll have problems with SMP. After all it is
test1 only :-).

At the moment the known problems with this new RTAI are mine. In fact
I've not made  netrpc working yet. For the rest most user space examples
in showroom seems to be OK under UP, but examples involving kernel
modules do not even compile. The core RTAI testsuite works well however
in both kernel and user space.

So give a try, have fun and help to make it better.

Happy Easter.

Paolo.

