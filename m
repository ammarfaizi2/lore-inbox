Return-Path: <linux-kernel-owner+w=401wt.eu-S1754038AbWLROC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbWLROC7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbWLROC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:02:59 -0500
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:34912
	"HELO smtpout04-04.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754037AbWLROC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:02:58 -0500
Message-ID: <45869F8F.2020009@seclark.us>
Date: Mon, 18 Dec 2006 09:02:55 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Cloos <cloos@jhcloos.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       James Lockie <bjlockie@lockie.ca>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: escape key]
References: <1166058290.2964.15.camel@monteirov>	<20061213214140.df6111f5.randy.dunlap@oracle.com>	<4580E985.2090208@lockie.ca> <20061216084542.GD4049@ucw.cz>	<Pine.LNX.4.61.0612161922530.30896@yvahk01.tjqt.qr> <m3bqm20zj8.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3bqm20zj8.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cloos wrote:

>>>>>>"Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>>>>>>            
>>>>>>
>
>Jan> HOWEVER, unix people probably _had a reason_ to make ESC generate
>Jan> part of what function keys do.
>
>You are looking at it backwards.  The Escape key generates an ASCII
>escape.  The funtion keys (including the cursor keys) generate escape
>sequences because the vt100 won out the title as the most ubiquitous
>async serial terminal, and linux devs chose to have the console be
>(mostly) vt100 compatable.  As xterm, et al had done before.
>
>The terminals (the actual hardware) used ASCII, so it was normal to
>use Escape to initiate the sequences used by the function keys.
>
>And that concept goes back a *lot* longer than unix.  (Hmm.  I can't
>remember.  Did TOPS-20 or its predecessor have glass terminals in the
>day?  I did get to use a DEC paper terminal a couple of times, but
>that was connected to a VMS box back in the '80s; most of the time it
>sat in the corner collecting dust....)
>
>At any rate, given that Escape was used to initiate sequences sent to
>the terminal for funtions such as moving the cursor around the screen,
>clearing rows or cols, et al it must have only seemed natural to also
>have it initiate sequences /from/ the terminal which did not fit into
>standard ASCII.  That was after all Escape's purpose in the ASCII std.
>
>If you do want to change the console's terminal emulation, a good
>first step would be to check whether any existing terminal already
>uses something other than Escape to initiate function key sequences,
>and, if so, promote that as the alternative to vt100-esque emulation.
>
>Finally, note that the reason vt100 was chosen for the console was to
>make it more useful for users who were physically at a linux box, were
>logged in on the console, and from there logged in to remote servers.
>That does remain something which the console *must* support.
>
>-JimC
>  
>
Also ansi came along and pretty much put their blessing on what DEC had 
done and made the
escape sequences a standard.

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



