Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312803AbSDGXfy>; Sun, 7 Apr 2002 19:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDGXfx>; Sun, 7 Apr 2002 19:35:53 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:59381 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S312803AbSDGXfx>; Sun, 7 Apr 2002 19:35:53 -0400
Message-ID: <3CB0D7D8.6060909@bigpond.com>
Date: Mon, 08 Apr 2002 09:35:52 +1000
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: kbuild-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <28835.1018191216@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:

>It takes time to do all the analysis to work out what has changed and
>what has been affected.  You might know that you only changed one file
>but kernel build and make don't know that until they have checked
>everything.  Changing one file or specifying a command override might
>affect one file or it might affect the entire kernel.
>
>If you know that you have only changed one source file and you have not
>altered the Makefiles or the dependency chain in any way, then it
>_might_ be safe to just rebuild that one file, use NO_MAKEFILE_GEN=1.
>Otherwise let kbuild work out what has been affected.
>
Humans/Hackers are really really REALLY good at making assumptions and 
using assumptions that are outdated, thus leading to mistakes. 
 Some/many hackers like to live in there own little world and not worry 
about the effect they might have on other developers.  Using a 
dependency maintenance tool (such as Make, Cook, ...) to automate the 
build is the _ONLY_ safe way to be sure the build is correct.  This 
assumes that the build system itself is 100% correct :)

Regards,
Brendan Simon.


