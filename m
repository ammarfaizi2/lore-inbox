Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWFYXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWFYXEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWFYXEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 19:04:45 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:27744 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932413AbWFYXEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 19:04:44 -0400
Message-ID: <449F169C.7080304@sbcglobal.net>
Date: Sun, 25 Jun 2006 18:05:00 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: artusemrys@sbcglobal.net
CC: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de>	 <20060624181702.GG27946@ftp.linux.org.uk>	 <1151198452.6508.10.camel@mjollnir> <449E216E.8010508@sbcglobal.net> <bda6d13a0606251309x3e07e9feoad777d9a062f923f@mail.gmail.com> <449F0B44.6050407@sbcglobal.net>
In-Reply-To: <449F0B44.6050407@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost wrote:
> Joshua Hudson wrote:
>> I feel like asking how they initially get set to world-writable. To me
>> it means that the tree that is being tarred up for distribution is
>> world-writible. I sure hope that it is a single-user box.
>> -
> 
> Yeah.  Having said, "Take advice", I'm also curious as to just the 
> why/how of the current configuration and the work patterns that create 
> it.  I get the impression that there *is* a reason for it, because if it 
> were just a security issue, I can't see this much resistance to changing 
> it.  Sane tar permissions and sensible usage aside.
> 
> The kernel untar-and-compile procedure has been documented this way 
> since at least 2000, from Linus.  There's a good recent (and short) 
> discussion from Jesper Juhl on LXer that references it, as well.
> 
> http://uwsg.iu.edu/hypermail/linux/kernel/0007.3/0587.html
> http://lxer.com/module/forums/t/22410/
> 
> The previous two l-k threads I can find on this topic (one listed 
> earlier in this thread, one referenced from it) don't seem to be any 
> more revelatory about why the tarball is as it is.  I might guess that 
> it has to do with how changes get checked in, but I also have the vague 
> memory that these aren't tar()ed on a development box.  I could be 
> wrong.  Consider me seconding the "Why?" aspect, if anybody's still 
> listening.  :)
> 
> Matt

No, I'm an idiot.  Blockquoted here (Norbert van Nobelen):
"The rights on the files should be sufficient for the compiler to go 
through the tree and compile the kernel for you. If it bothers you, you 
can just run chmod -R to correct it.
I guess that it will not be corrected."
http://marc.theaimsgroup.com/?l=linux-kernel&m=113304353113129&w=2
