Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130834AbRCJCPT>; Fri, 9 Mar 2001 21:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbRCJCPJ>; Fri, 9 Mar 2001 21:15:09 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:24820
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S130834AbRCJCO6>; Fri, 9 Mar 2001 21:14:58 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Subject: Re: Microsoft begining to open source Windows 2000?
Date: Fri, 9 Mar 2001 20:10:50 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Graham Murray <graham@webwayone.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200103091247.NAA31936@cave.bitwizard.nl>
In-Reply-To: <200103091247.NAA31936@cave.bitwizard.nl>
MIME-Version: 1.0
Message-Id: <01030920140700.10781@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2001, Rogier Wolff wrote:
>Jesse Pollard wrote:
>> On Fri, 09 Mar 2001, Graham Murray wrote:
>> >"Mohammad A. Haque" <mhaque@haque.net> writes:
>> >
>> >> making a patch means you've modfied the source which you are not allowed
>> >> to do. The most you can do is report the bug through normal channels
>> >> (you dont even have priority in reporting bugs since you have the code).
>> >
>> >Does making a patch necessarily require modifying the source code?
>> >Back in my days as a mainframe systems programmer (ICL VME/B), most OS
>> >patches were made to the binary image, either in the file or to the
>> >loaded virtual memory image.
>
>> Nearly always. The problem is that the patch may make the module
>> bigger/smaller or relocate variables whose address then changes. All
>> locations that these are referenced must be modified (either direct
>> address or offset).  Sometimes other modules will get relocated too.
>
>You're too young. Or I'm too old. :-)

Neither - we've both been there.
>
>IF your patch can be inserted into the code space available: Then good. 
>If not, you move the code out of the previously allocated space, and
>put it somewhere else. Put a "jump" instruction in the old place. 
>

Only if you generate your patch in assembler.... and there is somewhere
else to put the real module...

>At the university there was a lab-assignment where we had to use the
>provided semaphore routines. Turns out we found a bug. The TA then
>told us it was going to be hard-to-fix, as about 8192 bytes of the 8k
>PROM were in use. He was wrong. The bug was one instruction too
>many. We just wrote "nop" over the bad instruction. The processor had
>also been correctly designed: you could overwrite any instruction in
>the PROM with "nop", as the NOP instruction was 0xff. Fixed on the
>spot!
>

Congratulations - We used to do similar things to change the baud
rate of serial interfaces (though overwriting core memory was much
easier).
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
