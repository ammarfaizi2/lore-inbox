Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267695AbUHJVDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267695AbUHJVDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUHJVDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:03:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11184 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267695AbUHJVDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:03:23 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810173756.GB22928@redhat.com>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <20040810085849.GC26081@elte.hu> <1092157841.3290.3.camel@mindpipe>
	 <1092155147.16979.33.camel@localhost.localdomain>
	 <20040810173756.GB22928@redhat.com>
Content-Type: text/plain
Message-Id: <1092171823.5061.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 17:03:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 13:37, Dave Jones wrote:

> Depends which C3.  If OP's C3 lacks cmov, it definitly is not ok.
> Any cmov ending up in that module will blow up.
> 

Argh, never mind, this was an ALSA bug, reverting to CVS from two days
ago fixed it.

Lee

