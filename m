Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUHaT4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUHaT4P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUHaTwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:52:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33748 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269072AbUHaTrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:47:19 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831193734.GA29852@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net>
	 <20040831193734.GA29852@elte.hu>
Content-Type: text/plain
Message-Id: <1093981634.1633.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 15:47:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 15:37, Ingo Molnar wrote:
> i believe that the invalidations are excessive. It is quite likely that
> no invalidation has to be done at all. Does your box still start up X
> fine if you uncomment all those wbinvd() calls?
> 

Commented out all calls to wbinvd(), seems to work fine.  I even tried
repeatedly killing the X server before it could finish starting, no
problems at all.

I guess the worst that could happen here would be display corruption,
which would get fixed on the next refresh?

Lee

