Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135663AbRAJOlZ>; Wed, 10 Jan 2001 09:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135645AbRAJOlP>; Wed, 10 Jan 2001 09:41:15 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:7954 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135630AbRAJOlK>;
	Wed, 10 Jan 2001 09:41:10 -0500
Date: Wed, 10 Jan 2001 11:12:07 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux-2.4.x patch submission policy
Message-ID: <20010110111207.A4231@grobbebol.xs4all.nl>
In-Reply-To: <20010108223343.O10035@nightmaster.csn.tu-chemnitz.de> <Pine.LNX.4.21.0101081837520.21675-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101081837520.21675-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Jan 08, 2001 at 06:40:21PM -0200
X-OS: Linux grobbebol 2.2.19pre6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 06:40:21PM -0200, Rik van Riel wrote:
> I wasn't aware Andrea switched the way he stored his patches
> lately ;)

he's doing that for quite some time now (for suse's kernels too) and
that works pretty well :-)
 
> OTOH, the advantage of having a big patch means that it's
> easier for me to get people to test all of the things I
> have. Guess I'll need to find a way to easily get both the
> small and the big patches ;)


the trouble with that is also that the whole patch must be checked again
and again if a new version is being sent out. Andrea's patches have th
epossibility to be applied for several versions and indeed are easy to
use -- apply what you want.

it made SMP testing more fun compared to the big patches where nobody
exactly knows what patch may have caused [in]stability.

I for instance have the daunting task to check why 2.4.0 here crashes so
easily without messages, except some occasional APIC error. yuck.
-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
