Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133018AbREHRje>; Tue, 8 May 2001 13:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbREHRjU>; Tue, 8 May 2001 13:39:20 -0400
Received: from 3-CORU-X5.libre.retevision.es ([62.83.56.3]:53124 "HELO
	trasno.mitica") by vger.kernel.org with SMTP id <S133018AbREHRi6>;
	Tue, 8 May 2001 13:38:58 -0400
To: slurn@verisign.com
Cc: george@mvista.com (george anzinger), kaos@melbourne.sgi.com (Keith Owens),
        kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kdb wishlist
In-Reply-To: <200105081657.JAA05739@slurndal-lnx.verisign.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200105081657.JAA05739@slurndal-lnx.verisign.com>
Date: 08 May 2001 19:38:06 +0200
Message-ID: <m2itjbspvl.fsf@trasno.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "slurn" == slurn  <slurn@verisign.com> writes:

>> 
>> Keith Owens wrote:
>> > 
>> > This is part of my kdb wishlist, does anybody fancy writing the code to
>> > add any of these features?  It would be a nice project for anybody
>> > wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
>> > Current patches at http://oss.sgi.com/projects/kdb/download/
>> > 
>> > * Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
>> >   used by emacs, bash, minicom etc.
>> > 
>> ^X^X swaps point and mark in emacs.  One (well, I) often will do
>> ^X^X^X^X to examine where mark is and then return to point.

slurn> How about using the break condition instead.  This is only for the
slurn> serial port, and most terminal emulators (e.g. kermit, minicom) provide
slurn> a means to generate a break condition on the serial port. 

kdb uses BREAK in the serial port (that minicom uses C-a for sending a
break is an anecdote :)  But the problem at hang is the console.  I
vote for the ^X^X^X as I a think that it is not a difficult shortcut.
(and yes, I also use emacs and ^X^X all the time, but I think that
this combination is not specially bad, and I suppose that the pet
aplication of other people will have problems with something like:
^A^A^A that I never use). 

Later, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
