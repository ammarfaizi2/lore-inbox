Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWA3UZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWA3UZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWA3UZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:25:06 -0500
Received: from host233.omnispring.com ([69.44.168.233]:61071 "EHLO
	iradimed.com") by vger.kernel.org with ESMTP id S964948AbWA3UZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:25:05 -0500
Message-ID: <43DE75F5.40900@cfl.rr.com>
Date: Mon, 30 Jan 2006 15:24:21 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h37 <43DE495A.nail2BR211K0O@burner>
In-Reply-To: <43DE495A.nail2BR211K0O@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jan 2006 20:26:06.0156 (UTC) FILETIME=[65BC90C0:01C625DB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14238.000
X-TM-AS-Result: No--11.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> I am sorry to see your recent dicussion style.
>
> I was asking a question and I did get a completely useless answer as
> any person who has some basic know how Linux SCSI would know that
> doing a stat("/dev/sg*", ...) will not return anything useful.
>   

It certainly does return something useful, just not what you are looking 
for.  It does not return information that allows you to cleanly build 
your bus:device:lun view of the world, but it does return sufficient 
information to enumerate and communicate with all devices in the 
system.  Is that not sufficient to be able to implement cdrecord?  If it 
is, then the real issue here is that you want Linux to conform to the 
bus:device:lun world view, which it seems many people do not wish to do. 

Maybe it would be more constructive if you were to make a good argument 
for why the bus:device:lun view is better than /dev/*, but right now it 
seems to me that they are just two different ways of doing the same 
thing, and you prefer one way while the rest of the Linux developers 
prefer the other. 
> If people give useful answers, it makes sense to continue a discussion but it 
> turns out that "joe average" on KLML replies before thinking about the problem. 
>
> Let me ask again:
>
> 	Is there a way to get (or construct) a closed view on the namespace 
> 	for all SCSI devices?
>
>
> And IMPORTANT: don't answer unless you have a real answer for the problem.
>
> Jörg
>
>   

