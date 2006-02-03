Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422920AbWBCUCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWBCUCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWBCUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:02:32 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:49683 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422904AbWBCUCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:02:31 -0500
Message-ID: <43E3B6A5.5040507@cfl.rr.com>
Date: Fri, 03 Feb 2006 15:01:41 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mai <43E38B51.nail5CAZ1GYRE@burner>
In-Reply-To: <43E38B51.nail5CAZ1GYRE@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 20:03:06.0316 (UTC) FILETIME=[D8F0B0C0:01C628FC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No--6.000000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
>> You CAN'T have multiple cdrecord processes burning the same disc at the 
>> same time; the very idea makes no sense.  The O_EXCL just prevents you 
>> from trying such foolishness and creating a coaster. 
>>     
>
> It does not prevent you from creatig a coaster in case you connect e.g.
> two ATAPI writers to the same ATA cable.

So what?  What does that have to do with my rebutting your statement 
that O_EXCL prevents multiple cdrecords?  O_EXCL also does not prevent 
you from kicking the plug out of the wall while burning, but it DOES 
prevent another process from trying to mess with the drive while 
cdrecord is and clobbering things up, which is a good thing.  It does 
not prevent you from using cdrecord at the same time on different drives. 


