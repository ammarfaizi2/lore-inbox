Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135609AbRAJVE5>; Wed, 10 Jan 2001 16:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136421AbRAJVEh>; Wed, 10 Jan 2001 16:04:37 -0500
Received: from think.faceprint.com ([166.90.149.11]:22024 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S135609AbRAJVEe>; Wed, 10 Jan 2001 16:04:34 -0500
Message-ID: <3A5CCD62.A5D0C90D@faceprint.com>
Date: Wed, 10 Jan 2001 16:00:18 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Grobler <grobh@sun.ac.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.0-ac5
In-Reply-To: <Pine.LNX.4.30.0101102243010.30013-100000@prime.sun.ac.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Grobler wrote:
> 
> On Wed, 10 Jan 2001, Nathan Walp wrote:
> > Here it is... I opted to cut out the 1200-odd warnings, which from the
> > look of them were all because i'm running it under 2.4.0-ac4 (which
> > boots fine).
> 
> Thanks! My local mirror does not have -ac5 yet so I can't help
> immediately. From the -ac5 log & the oops it looks as if Ingo's change
> isn't quite complete yet...
> 
>   o       Uniprocessor APIC support/NMI wdog etc          (Ingo Molnar)
> 
> Until then, what about disabling APIC support and trying again. This
> will help confirm it... although it looks pretty definite.
> 
> -- Hans

I noticed (and was told by someone else) that it was APIC related.  I
looked, and realized that IO-APIC got selected between my compiles of
ac4 and ac5.  I recompiled ac5 w/o the IO-APIC stuff, and still got an
oops.  So, i recompiled without ANY APIC stuff, and it booted fine, but
then had the same problems I was having w/ 2.4.1-pre1 related to X and
(maybe) the framebuffer.  But that's a whole different story that I
think has been brought up in another thread.

Guess I'm back to -ac4 for now ;-)


Thanks,
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
