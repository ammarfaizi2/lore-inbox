Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTCFDCi>; Wed, 5 Mar 2003 22:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTCFDCi>; Wed, 5 Mar 2003 22:02:38 -0500
Received: from [216.234.192.169] ([216.234.192.169]:26897 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S267693AbTCFDCh>; Wed, 5 Mar 2003 22:02:37 -0500
Subject: Re: Those ruddy punctuation fixes
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305122008.GA4280@suse.de>
References: <20030305111015.B8883@flint.arm.linux.org.uk> 
	<20030305122008.GA4280@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 05 Mar 2003 20:11:11 -0700
Message-Id: <1046920285.3786.68.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 05:20, Dave Jones wrote:
> On Wed, Mar 05, 2003 at 11:10:15AM +0000, Russell King wrote:
> 
>  > Could we stop fix^wbreaking this stuff please.  GCC 3.2.2:
>  > ...
>  > include/asm/proc-fns.h:128:39: missing terminating ' character
> 
> 100% agreed. People really are going too far IMO.
> Given that most people will never read those comments, the
> effort would be much better spent proof-reading/correcting
> documentation than comments.
> 
> The "its just a spelling mistake, it cant break the build!"
> mantra is also way off base. If you touch a .c/.h file, you
> introduce the possibility of breakage.

That is why I was very careful with my its -> it's patch.
In the two files where an extra apostrophe would have broken
the build, I changed its to it is.  Why not just leave it alone?
Because some well-meaning spelling fixer may come along in the
future and break it, just like in proc-fns.h.

> 
> The cant -> can't pedantry is an example of just how extremely
> silly these are getting. Is there really someone who sees
> "cant" and doesn't understand what it could mean?
> It just pedantic masturbation AFAICS.
> 
> 		Dave

It's too bad that the cant -> can't change is tarred with the same brush
as thresold -> threshold and asociation -> association.  My belief is
that those kind of fixes have these benefits:

The comments are more readable.
The source can be grepped more accurately.
Correct spelling sets a good example.
Incorrect spelling sets a bad example and proliferates.

Why all the fixes now?  Because it's a window of opportunity. Linus
seems more comfortable with accepting these kind of changes now than at
other times.

If we don't get these changes in now, expect to have this same
conversation around 2.9.50 or so. (Assuming that 3.0 will follow 2.6)

Cheers,
Steven 

