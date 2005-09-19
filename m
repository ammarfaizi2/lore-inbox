Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVISBh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVISBh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 21:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVISBh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 21:37:57 -0400
Received: from boutiquenumerique.com ([82.67.9.10]:49129 "EHLO
	boutiquenumerique.com") by vger.kernel.org with ESMTP
	id S932285AbVISBh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 21:37:56 -0400
To: "Dan Oglesby" <doglesby@teleformix.com>,
       "David Masover" <ninja@slaphack.com>
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       "Christoph Hellwig" <hch@infradead.org>,
       "Denis Vlasenko" <vda@ilport.com.ua>, chriswhite@gentoo.org,
       "Hans Reiser" <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       "ReiserFS List" <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl> <432DCE2A.5070705@slaphack.com> <432DDF7A.3050704@teleformix.com>
Message-ID: <op.sxbtg9lzth1vuj@localhost>
Date: Mon, 19 Sep 2005 03:37:47 +0200
From: PFC <lists@boutiquenumerique.com>
Organization: =?iso-8859-15?Q?La_Boutique_Num=E9rique?=
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
In-Reply-To: <432DDF7A.3050704@teleformix.com>
User-Agent: Opera M2/8.0 (Linux, build 1095)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I'm of the same opinion.  If I have hardware that has a problem, and  
> causes downtime, it gets replaced or repaired.  I don't switch to a  
> different piece of software to compensate for broken hardware.
>
> With that said, I have seen ReiserFS expose hardware that had problems.   
> Hardware was repaired, and ReiserFS rides again.

	This summer :

	Coming back from vacation, looking at the logs, I saw that the cupboard  
router-server had kernel-panicked almost daily and rebooted itself  
automatically. I also had a lot of corrupted BitTorrent downloads. I could  
have blamed reiserfs, or bittorrent. But instead, I opened the case and  
found the CPU was overheating due to the fan being clogged by an  
unbelievable amount of accumulated dust and crap.

	reiserfs was still happy, I ran a fsck just to be sure, no errors. fhew.  
I wonder how it's possible. Given the state of the CPU fan, everything  
should have been wiped out.

	I have an all-reiser4 laptop (except /boot) and it's great. No problems  
whatsoever, it flies. Pentium-M kicks ass.
	My jukebox PC is half reiser3 and (since a few months) half reiser4,  
running fine, on the cheapest possible motherboard, and the no-name RAM,  
with an underclocked Duron. The hardware is so bad I had to underclock the  
PC133 to PC100. It has never crashed in 4 years, or got any data  
corruption. Crap hardware is actually sometimes pretty good if you  
underclock it (just have to get lucky). With windows, it used to  
bluescreen just by plugging a cable in the ethernet port.
	My server is all reiser3 too.

	I could have used other filesystems but reiserfs Just Works. No horror  
stories to tell, sorry. I  like reiserfs.
	I don't care it there were very old versions that crashed. I don't care  
about Linux 2.0 or 1 either. Or Netscape 2. That's the past now.

