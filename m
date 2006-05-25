Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWEYTDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWEYTDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWEYTDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:03:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2963 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030348AbWEYTDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:03:07 -0400
Date: Thu, 25 May 2006 21:02:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <200605251954.06227.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>[alistair] 19:53 [~] hostname
>damocles
>
>[alistair] 19:52 [~] hostname --fqdn
>localhost
>
>"localhost" isn't very descriptive if I'm trying to figure out which machine a 
>dmesg came from.
>
So, after we have coreutils and net-tools, what hostname do you run?

Here's the output of another machine (which actually does not have a domain 
part set):

20:35 mason:/etc # rpm -qf `which hostname`
net-tools-1.60-37
21:00 mason:/etc # hostname -v
gethostname()=`mason'
mason
21:00 mason:/etc # hostname --fqdn
mason
21:00 mason:/etc # domainname
(none)
21:00 mason:/etc # dnsdomainname


Runs Aurora Linux 2.0.


Jan Engelhardt
-- 
