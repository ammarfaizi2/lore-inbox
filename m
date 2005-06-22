Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVFVS6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVFVS6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFVS6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:58:16 -0400
Received: from opersys.com ([64.40.108.71]:57614 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261860AbVFVS5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:57:55 -0400
Message-ID: <42B9B742.2030005@opersys.com>
Date: Wed, 22 Jun 2005 15:08:50 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com>
In-Reply-To: <20050622185019.GG1296@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> Any way of getting the logger's latency separately?  Or the target's?

Like I said to Ingo in my other response, we're going to use a
technique similar to his lpptest (i.e. disable all interrupts and
actively wait for a reponse from the target) on the the logger to
settle the issue. I very seriously doubt the results will be any
different, but we want to make sure that there are no doubts
remaining.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
