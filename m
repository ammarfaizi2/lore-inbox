Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbRA0P1c>; Sat, 27 Jan 2001 10:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133090AbRA0P1W>; Sat, 27 Jan 2001 10:27:22 -0500
Received: from mailout2-0.nyroc.rr.com ([24.92.226.121]:17367 "EHLO
	mailout2-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S131823AbRA0P1F>; Sat, 27 Jan 2001 10:27:05 -0500
Message-ID: <3A72E8C7.138BB69E@rochester.rr.com>
Date: Sat, 27 Jan 2001 10:27:03 -0500
From: Mark Bratcher <mbratche@rochester.rr.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0a i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
In-Reply-To: <3A70EF20.1B02B307@rochester.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I applied the patch "loop-3", from Jen Axboe's 2.4.1-pre10 version, to
my 2.4.0 kernel as Jen had suggested we try for the loop device hang
problem.

This patch appears to have gotten rid of the problem (at least after
testing it once in my previous scenario, which would normally fail 100%
of the time on 2.4.0 official).

Thanks Jen!

Can I continue running this patch on 2.4.0 with impunity, or do I need
to be careful of anything else? :-)

Mark

Mark Bratcher wrote:
> 
> Hello,
> 
> I saw a post dated last fall 2000 sometime about the loop device hanging
> when copying large amounts of data to a file mounted as, say, ext2fs. It
> was in regard to kernel 2.4.0test-something.
> 
> I have the latest 2.4.0 kernel loaded on my system and this bug appears
> to be there, although I have seen other notes that claim that it is
> fixed.
> 
> Can anyone confirm whether this bug is "officially" known to be in the
> official 2.4.0 kernel? Currently I have to reboot to 2.2.17 to do my
> CD-RW backups.
> 
> Thanks.

-- 
Mark Bratcher
mailto:mbratche@rochester.rr.com
---------------------------------------------------------
Escape from Microsoft's proprietary tentacles: use Linux!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
