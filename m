Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbSKURk7>; Thu, 21 Nov 2002 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbSKURk7>; Thu, 21 Nov 2002 12:40:59 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:41009
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S266733AbSKURk5>; Thu, 21 Nov 2002 12:40:57 -0500
Message-ID: <3DDD0FCE.30600@WirelessNetworksInc.com>
Date: Thu, 21 Nov 2002 09:54:38 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2002 17:48:04.0998 (UTC) FILETIME=[24DE2A60:01C29186]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The way I read it, the GPL is not the monster that most people think it 
is.  In order to understand the GPL, you have to read all the acts that 
apply and that should start with the constitution of your country and 
state.  You cannot read the GPL in isolation and think that you 
understand it.  "Beware of a man of only one book", applies in this case.

Using a header file in proprietary code, could be argued as reverse 
engineering to ensure interoperability with another program.  This type 
of thing is described in the DMCA in the USA and in the copyright acts 
of other countries, which are all pretty much the same.  Since the GPL 
depends on the various Copyright acts, I think that using a GPL header 
in proprietary code to ensure compatibility, is allowed.

Another thing to bear in mind, is that 'fair use' is also allowed under 
the various copyright acts.  Consequently it can be argued that you may 
use *some* GPL code in proprietary code and the larger the base of GPL 
code becomes, the larger the amount of fair use that will be allowed. 
Since the total GPL code base of the kernel is now many megabytes in 
size, fair use of some kilobytes of GPL code may very well be reasonable.

Check this out with your own lawyers...

Cheers,
-- 

------------------------------------------------------------------------
Herman Oosthuysen
B.Eng.(E), Member of IEEE
Wireless Networks Inc.
http://www.WirelessNetworksInc.com
E-mail: Herman@WirelessNetworksInc.com
Phone: 1.403.569-5687, Fax: 1.403.235-3965
------------------------------------------------------------------------

Mark Mielke wrote:

 > On Wed, Nov 20, 2002 at 01:06:39AM -0200, Rik van Riel wrote:
 >
 >> On Wed, 20 Nov 2002, David McIlwraith wrote:
 >>
 >>> How should it? The compiler (specifically, the C preprocessor) includes
 >>> the code, thus it is not the AUTHOR violating the GPL.
 >>
 >>
 >> If the compiler includes a .h file, it happens because
 >> the programmer told it to do so, using a #include.
 >
 >
 >
 > I was recently re-reading the GPL and I came to the following conclusion:
 >
 > The GPL is only an issue if the software is *distributed* with GPL
 > software. Meaning -- it is not legal to distribute a linux kernel that
 > contains non-GPL code, however, it *is* legal for an administrator to
 > install linux, and then download a copy of the dynamically linked
 > module from a separate web site, under a different (incompatible)
 > license, and load it into the kernel. This new kernel image is a
 > 'derived work', however, as long as the new kernel image is not
 > distributed to 'the public', the GPL terms do *not* come into play.
 >
 > While I believe my understanding on this issue to be correct, I still
 > haven't answered the original question... is it legal to distribute a
 > non-GPL binary that used a GPL header file to be compiled? Is the
 > answer to this different depending on the amount of code that is
 > generated using the GPL header file as source (i.e. inlined
 > functions)?
 >
 > mark
 >


