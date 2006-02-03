Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWBCQLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWBCQLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWBCQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:11:35 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:5849 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751135AbWBCQLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:11:35 -0500
Message-ID: <43E38084.9040200@cfl.rr.com>
Date: Fri, 03 Feb 2006 11:10:44 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: acahalan@gmail.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43DDFBFF.nail16Z3N3C0M@burner> <1138710764.17338.47.camel@juerg-t40p.bitron.ch> <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mai <43E374CF.nail5CAMKAKEV@burner>
In-Reply-To: <43E374CF.nail5CAMKAKEV@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Feb 2006 16:12:05.0756 (UTC) FILETIME=[936713C0:01C628DC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14245.000
X-TM-AS-Result: No-0.700000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> As including O_EXCL would disallow to use more than one cdrecord
> program at the same time, there is no chance for the mains stream source.
>
>   

You CAN'T have multiple cdrecord processes burning the same disc at the 
same time; the very idea makes no sense.  The O_EXCL just prevents you 
from trying such foolishness and creating a coaster. 


