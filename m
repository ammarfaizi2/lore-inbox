Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284866AbRLXNk3>; Mon, 24 Dec 2001 08:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284868AbRLXNkT>; Mon, 24 Dec 2001 08:40:19 -0500
Received: from tourian.nerim.net ([62.4.16.79]:46091 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S284866AbRLXNkG>;
	Mon, 24 Dec 2001 08:40:06 -0500
Message-ID: <3C273028.6070305@free.fr>
Date: Mon, 24 Dec 2001 14:39:52 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011220
X-Accept-Language: en-us
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: Steven Cole <scole@lanl.gov>, linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov> <20011220135213.B18128@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

> 
> 
> This change came as a patch from David Woodhouse.  I think the new
> abbreviations are awful ugly, myself, but they do have the virtue of
> not being ambiguous.  So I swallowed hard and took the patch.
> 

This could even have the nice side effect of teaching something to Linux 
newbies (mainly the fact that the difference between 2^10 and 10^3 
matters in some areas). I see 2 cases :

- already encountered the kiB/MiB/GiB notation and understood the 
meaning: no problem if we take out of the equation the aesthetic of the 
abreviations.

- this is a new thing for the reader, 3 cases:
  . Computer literate person : she uses her intuition and understand its 
meaning : no problem apart the time used to put her intuition at work,
  . Computer illiterate person which don't care enough : she doesn't 
understand the difference with kB/MB/GB and takes the notation as a 
different syntax but with the same semantic : the only problem would be 
a temporary confusion (from a fraction of a second to several minutes) 
until this assumption is made. It certainly would be made by computer 
illiterate people who are lost in the first place: we trade a 
misunderstanding for another.
  . Computer illiterate person which really tries to understand : she 
doesn't understand and take the time to document herself : no problem 
she might discover something she didn't even thought about.

This is a simplified view but I believe the actual readers' behaviour 
would be somehow a combination of several of the above cases.

So what's the tradeoff :
* aesthetic and shor time spent in temporary confusion or reflexion
* for clarity and education of some people in the end.

Hiding complexity in the docs would only keep some users ignorant.
This is my personal opinion but don't we prefer educated users instead 
of ignorant ones ?

I find the choice obvious...
We could argue on the choice of these particular abreviations against 
others but as I don't see any other around...

LB

