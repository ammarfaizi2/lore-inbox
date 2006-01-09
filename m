Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWAIWUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWAIWUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWAIWUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:20:55 -0500
Received: from drugphish.ch ([69.55.226.176]:60114 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751557AbWAIWUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:20:54 -0500
Message-ID: <43C2E243.5000904@drugphish.ch>
Date: Mon, 09 Jan 2006 23:22:59 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local> <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch> <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch> <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu>
In-Reply-To: <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
> that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".

Brain is engaged now, thanks ;). If you find time, could you maybe 
compile a 2.4.32 kernel using following config (slightly changed from 
yours):

http://www.drugphish.ch/patches/ratz/kernel/configs/config-2.4.32-chris_s

And put a dmidecode[1] output onto your website. Is the BMC interface 
enabled in your BIOS?

[1] http://download.savannah.nongnu.org/releases/dmidecode/

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc
