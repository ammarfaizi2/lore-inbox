Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270828AbTG0P4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270829AbTG0P4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 11:56:39 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:52422 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270828AbTG0P4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 11:56:38 -0400
Message-ID: <3F23FD97.60207@genebrew.com>
Date: Sun, 27 Jul 2003 12:28:07 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net>	 <200307271301.41660.adq_dvb@lidskialf.net> <3F23DB4E.1000203@genebrew.com>	 <200307271514.00724.adq_dvb@lidskialf.net>  <3F23E538.6010900@genebrew.com> <1059320761.13190.9.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059320761.13190.9.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2003-07-27 at 15:44, Rahul Karnik wrote:
> 
>>Dunno. Look in the list archives for earlier discussions on the topic. 
>>It seems AMD audio is a clone of Intel audio, which is why Intel audio 
>>works for NForce. Since both audio and ethernet match, it seems unlikely 

s/ethernet/IDE, oops.

>>that Nvidia would license a completely different ethernet chip, but who 
>>knows?
> 
> 
> AMD's older network component is the AMD PCnet32, which is a very
> different chip.

Yes we tried that as well, with no success. See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105831948827945&w=2

As far as I can tell, NForce is based on AMD8111, at least for IDE and 
sound. Unfortunately, ethernet is a no-go so far with amd8111e.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

