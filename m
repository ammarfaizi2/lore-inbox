Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTDXUHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTDXUHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:07:17 -0400
Received: from watch.techsource.com ([209.208.48.130]:16019 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263448AbTDXUHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:07:16 -0400
Message-ID: <3EA84AAA.2060407@techsource.com>
Date: Thu, 24 Apr 2003 16:35:54 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
References: <Pine.LNX.4.44.0304241219550.22144-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On Thu, 24 Apr 2003, Timothy Miller wrote:
>  
>
>>For their smaller devices, Xilinx has a free "WebPack" which is a 
>>complete Verilog synthesizer (I don't know if it does VHDL), as well as 
>>place & route, of course.  I think it'll do up to Virtex II 250.  It 
>>also tends use fewer gates for a given design than the version of 
>>Leonardo Spectrum we have.  It just doesn't have a simulator, which is 
>>vital to any good development process.  Also, the Web Pack only runs 
>>under Windows.  Maybe it'll work with WINE?
>>    
>>
>
>It does work with wine - but it's sad how horrible the command line tools
>are (they were apparently first done under UNIX, and then ported to 
>Windows, and they got the Windows command line interface and trying to use 
>them in a sane way with Wine is not exactly much fun).
>
>But yes, with Wine and a few scripts you can actually make the tools 
>usable under Linux - I tried them out and had a small silly "pong" game 
>running on one of those things (a 100k device on one of the cheap 
>development boards).
>
>I have to admit that I would hate to actually use those tools for any real 
>work, though. 
>
>  
>
Where I work we have used the Web Pack (5.1, I believe) for "real work", 
although you can't trust its static timing.  Beyond a certain 
utilization, it completely lies to you, and we can't get it to work 
right, no matter how much we over-constrain a design.  All we can do is 
synthesize and then thoroughly test in real hardware (which isn't hard 
to do when all you're doing is a simple pixel-processing pipeline -- 
either it works, or you get obvious sprinkless all over the monitor 
screen).  If that doesn't work, we get really clever to reduce area, or 
we go to a bigger device.  What can you do with free but closed-source 
software?  :)  Designing for FPGA's is a real pain.  Although the ASIC I 
did was a lot more complex, the process was a lot more straight-forward 
and the tools didn't lie to you.


