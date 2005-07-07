Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVGGGEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVGGGEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVGGGEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:04:53 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:35341 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261153AbVGGGEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:04:52 -0400
Message-ID: <42CCC5FD.6070101@stud.feec.vutbr.cz>
Date: Thu, 07 Jul 2005 08:04:45 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
CC: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk>	 <200507062200.08924.s0348365@sms.ed.ac.uk> <20050706210249.GA2017@elte.hu>	 <200507062315.07536.s0348365@sms.ed.ac.uk> <1120691329.6766.62.camel@cmn37.stanford.edu>
In-Reply-To: <1120691329.6766.62.camel@cmn37.stanford.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.0 UPPERCASE_25_50        message body is 25-50% uppercase
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Lopez-Lezcano wrote:
> I see the same thing. "CONFIG_PRINTK_IGNORE_LOGLEVEL is not set" but
> still printk ignores the loglevel (I commented out the #ifdef in
> kernel/printk.c to make the spurious messages go away). 

The condition is reversed.
The '#ifdef CONFIG_PRINTK_IGNORE_LOGLEVEL' should be
'#ifndef CONFIG_PRINTK_IGNORE_LOGLEVEL'.

Michal
