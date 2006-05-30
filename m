Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWE3Skp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWE3Skp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWE3Skp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:40:45 -0400
Received: from mexforward.lss.emc.com ([168.159.213.200]:31837 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S932383AbWE3Sko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:40:44 -0400
Message-ID: <447C918F.2080801@emc.com>
Date: Tue, 30 May 2006 14:40:15 -0400
From: Ric Wheeler <ric@emc.com>
Reply-To: ric@emc.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mark Lord <liml@rtr.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patch] libata resume fix
References: <20060528203419.GA15087@havoc.gtf.org> <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca> <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.5.30.111406
X-PerlMx-Spam: Gauge=, SPAM=0%, Reasons='EMC_BODY_PROD_2+ -3, EMC_FROM_0+ -2, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 30 May 2006, Mark Lord wrote:
>  
>
>>Not in a suspend/resume capable notebook, though.
>>
>>I don't know of *any* notebook drives that take longer
>>than perhaps five seconds to spin-up and accept commands.
>>Such a slow drive wouldn't really be tolerated by end-users,
>>which is why they don't exist.
>>    
>>
>
>Indeed. In fact, I'd be surprised to see it in a desktop too.
>
>At least at one point, in order to get a M$ hw qualification (whatever 
>it's called - but every single hw manufacturer wants it, because some 
>vendors won't use your hardware if you don't have it), a laptop needed to 
>boot up in less than 30 seconds or something.
>
>And that wasn't the disk spin-up time. That was the time until the Windows 
>desktop was visible.
>
>Desktops could do a bit longer, and I think servers didn't have any time 
>limits, but the point is that selling a disk that takes a long time to 
>start working is actually not that easy. 
>
>The market that has accepted slow bootup times is historically the server 
>market (don't ask me why - you'd think that with five-nines uptime 
>guarantees you'd want fast bootup), and so you'll find large SCSI disks in 
>particular with long spin-up times. In the laptop and desktop space I'd be 
>very surprised to see anythign longer than a few seconds.
>
>		Linus
>  
>
With many data centera applications, delayed spin up of SCSI (and 
increasingly S-ATA) drives is a feature meant to avoid blowing a circuit 
when you spin up too many drives at once ;-)

Ric

