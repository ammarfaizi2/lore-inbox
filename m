Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUEMTga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUEMTga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUEMTgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:36:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49593 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264453AbUEMTTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:19:32 -0400
Message-ID: <40A3CA34.60202@pobox.com>
Date: Thu, 13 May 2004 15:19:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Paul Wagland <paul@wagland.net>,
       mingo@elte.hu
CC: wli@holomorphy.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <40A26FFA.4030701@pobox.com>	<20040512193349.GA14936@elte.hu>	<200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>	<Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>	<200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>	<20040512202807.GA16849@elte.hu>	<20040512203500.GA17999@elte.hu>	<20040512205028.GA18806@elte.hu>	<20040512140729.476ace9e.akpm@osdl.org>	<20040512211748.GB20800@elte.hu>	<20040512221823.GK1397@holomorphy.com>	<61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net> <20040513121141.37f32035.akpm@osdl.org>
In-Reply-To: <20040513121141.37f32035.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For whomever winds up doing this work, I have two requests:

* use a type-safe inline rather than purely a macro, as some drivers do
* replace msecs_to_jiffies() occurrences as well as MSECS_TO_JIFFIES() 
(and ditto for jiffies_to_msecs)



