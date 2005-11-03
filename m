Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVKCV2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVKCV2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVKCV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:28:35 -0500
Received: from www.eclis.ch ([144.85.15.72]:49801 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030481AbVKCV2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:28:35 -0500
Message-ID: <436A8100.6090609@eclis.ch>
Date: Thu, 03 Nov 2005 22:28:32 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org, dean@arctic.org
Subject: Re: NTP broken with 2.6.14
References: <4369464B.6040707@eclis.ch>	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>	 <43694DD1.3020908@eclis.ch>	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>	 <43695D94.10901@eclis.ch>	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>	 <43697550.7030400@eclis.ch>	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>	 <20051103195124.GE9488@csclub.uwaterloo.ca> <1131048670.27168.573.camel@cog.beaverton.ibm.com>
In-Reply-To: <1131048670.27168.573.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz a écrit :

>>This is happening on an Asus A7N8X-E-DX with an Athlon XP 2800+.  I have
>>acpi enabled, so who knows if that is what is breaking things.  There
>>does seem to have been time keeping issues on ati chipsets big time in
>>recent kernels, and some other acpi issues at times, so it wouldn't
>>surprise me if a fix for one issue causes problems on another chipset.
>>The chipset on this board is the nforce2.
> 
> 
> Yea, we have some issues with a few specific chipsets, but those were
> not regressions to my knowledge. 
> 
> Hmm. Check bug #5038 to see if sounds familiar.
> http://bugzilla.kernel.org/show_bug.cgi?id=5038

Interresting bug report. You have to know that the machine (nForce2 
based) that have the ntpd problem is NFS root and import via NFS several 
mount points. In fact this machine don't have any hard disk and make 
everything over NFS. ( This way, with a passiv water cooling and passiv 
power supply I enjoy an absolutly silent dektop. )

I have an other machine (VIA based) with a kernel 2.6.12 that is NFS 
root the same way but don't have the ntpd problem.

-- 
Jean-Christian de Rivaz
