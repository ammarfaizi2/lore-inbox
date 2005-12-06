Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVLFLoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVLFLoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLFLoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:44:15 -0500
Received: from www.eclis.ch ([144.85.15.72]:36245 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S932136AbVLFLoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:44:14 -0500
Message-ID: <4395798D.6040201@eclis.ch>
Date: Tue, 06 Dec 2005 12:44:13 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ntp problems
References: <200512050031.39438.gene.heskett@verizon.net> <200512052107.24427.gene.heskett@verizon.net> <1133839229.7605.63.camel@cog.beaverton.ibm.com> <200512052301.16998.gene.heskett@verizon.net>
In-Reply-To: <200512052301.16998.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett a écrit :

>>Hmmm. Indeed the nforce2 has had a number of problems, but I'm not sure
>>why it would have changed recently. Can you bound at all the kernel
>>versions where it worked and where it broke? Additionally, do be sure
>>you have the most recent BIOS, I've seen a number of nforce2 issues be
>>resolved with a BIOS update.
> 
> 
> I've already put more powerdown cycles (60 some) on my hard drives 
> fighting with the recent tv card problem, I'd like to get some uptime 
> in.  All I know for sure is if I build 2.6.15-rc5 with acpi, ntpd 
> doesn't work.  ntpdate does, but ntpd doesn't.  And both dmesg and the 
> ntp.log (and -d's passed at launch time do not make it more verbose, 
> they just keep it from starting) are silent as to the diffs other than 
> the interrupt number shuffling in dmesg when its on.  But I suspect it 
> may have started with 2.6.15-rc2, and I didn't build rc1.  And I *think* 
> it worked as recently as 2.6.14.1 with it turned on.  I've cleaned house 
> in /usr/src's so I don't have anything older.  Sorry.

I have to agree with John Stultz. I am one with a nForce2 chipset where 
updating to the latest BIOS have totaly solved the excatly same ntpd 
problem.

Regards,
-- 
Jean-Christian de Rivaz
