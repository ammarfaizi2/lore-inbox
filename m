Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVC2WS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVC2WS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVC2WOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:14:51 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:3565 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261569AbVC2WNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:13:06 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
	 <1112084311.5353.6.camel@gaston>
	 <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 17:13:04 -0500
Message-Id: <1112134385.5386.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 11:22 +0200, Marcin Dalecki wrote:
> No. You didn't get it. I'm taking the view that mixing sound is simply
> a task you would typically love to make a DSP firmware do.
> However providing a DSP for sound processing at 44kHZ on the same
> PCB as an 1GHZ CPU is a ridiculous waste of resources. Thus most 
> hardware
> vendors out there decided to use the main CPU instead. Thus the 
> "firmware"
> is simply running on the main CPU now. Now where should it go? I'm 
> convinced
> that its better to put it near the hardware in the whole stack. You 
> think
> it's best to put it far away and to invent artificial synchronization
> problems between different applications putting data down to the
> same hardware device.

This is the exact line of reasoning that led to Winmodems.

Lee

