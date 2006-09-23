Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWIWPci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWIWPci (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWIWPci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:32:38 -0400
Received: from main.gmane.org ([80.91.229.2]:62599 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751240AbWIWPch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:32:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: The GPL: No shelter for the Linux kernel?
Date: Sat, 23 Sep 2006 15:32:13 +0000 (UTC)
Message-ID: <slrnehaksq.3qb.olecom@deen.upol.cz.local>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com> <Pine.LNX.4.64.0609221440470.4388@g5.osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-09-22, Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Fri, 22 Sep 2006, David Schwartz wrote:
>> 
>> This is probably going to be controversial, but Linus should seriously
[...]
>
> I don't actually want people to need to trust anybody - and that very much 
> includes me - implicitly.
>
> I think people can generally trust me, but they can trust me exactly 
> because they know they don't _have_ to.

And somebody chooses anoter license, f.e see:
linux/drivers/video/aty/radeon_base.c

>
> Now, I could have done it all directly on the Linux-kernel mailing list, 
> but let's face it, that would just have caused a long discussion and we'd 
> not have really been any better off anyway. So instead, I did
>
> 	git log | grep -i signed-off-by: |
> 		cut -d: -f2- | sort | uniq -c | sort -nr | less -S
>
> which anybody else can do on their copy of their git repository, and I 
> just picked the first screenful of people (and Alan. And later we added 
> three more people after somebody pointed out that some top people use 

Alan *is on top* of (old fashioned, gitless):

$ for i in `find linux/drivers/`
do dd count=1 <$i | grep @ | sed 's_[^<]*<\(.*@.*\)>[^>]*_\1_g'
done | sort | uniq -c | sort -rn | most

And what about linux/CREDITS ? Creating (even in the past) is also worth.

As Adrian Bunk noted, there are may who contibuted, still CREDITS has
reasonable size. Search above && grep in CREDITS 50 / 50 from the git
logs would be better ;D.

I would, say

      H. Peter Anvin, Vojtech Pavlik, Patrick Mochel, Pavel Machek

are also major contributors. Cheers, guys !
[i usually do credit search on stuff i read in the kernel, so that is IMHO]

-o--=O`C   5 years ago TT and WTC7 were assassinated.
 #oo'L O   Learn more how (tm) <http://911research.com>
<___=E M
  

