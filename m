Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292586AbSBZBDN>; Mon, 25 Feb 2002 20:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSBZBDF>; Mon, 25 Feb 2002 20:03:05 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:189 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S292586AbSBZBCs>; Mon, 25 Feb 2002 20:02:48 -0500
Date: Mon, 25 Feb 2002 19:02:41 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
Message-ID: <20020225190241.C26077@asooo.flowerfire.com>
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on Tue, Feb 26, 2002 at 01:35:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I agree that -aa (or -rmap -- something to rescue the VM) should
go in ASAP, applying O(1) is a little more questionable.  I've been
applying O(1) for a while with great results, but it could be construed
as changing significantly the behavior of a stable kernel series.  I
don't know if it does, but I can see it breaking certain apps or modules
that relied on previous behavior.  Kind of like that parent vs. child
scheduling issue of a few months ago.  But I could be all wet on that.

It should be in it's own release separate from other major changes at
least, IMHO, if the backport is desired by enough folk to outweigh the
largish change.  And I definitely have VM _way_ higher up my personal
list. :)

-- 
Ken.
brownfld@irridia.com

On Tue, Feb 26, 2002 at 01:35:18AM +0100, Dieter Nützel wrote:
| Without them we do _NOT_ calm the flamewar against Linux's 2.4 VM.
| Second, it is time for the outstanding ReiserFS patches.
| If we are somewhat risky we put Ingo's GREAT O(1)-scheduler in, too.
| Preemption is than another story.
| 
| Thank you for any feedback in advance.
| This not intended as a flamewar start.
| 
| -Dieter
| -- 
| Dieter Nützel
| Graduate Student, Computer Science
| 
| University of Hamburg
| Department of Computer Science
| Ohome: Dieter.NuetzelOhamburg.de
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomoOvger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
