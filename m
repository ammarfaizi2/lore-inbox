Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266803AbUGVRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266803AbUGVRYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUGVRYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 13:24:32 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:4490 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266803AbUGVRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:24:31 -0400
Date: Thu, 22 Jul 2004 19:24:28 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: voluntary-preempt I0: sluggish feel
Message-ID: <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722161941.GA23972@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> thx for the report - i fixed this in the -I0 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I0
> 
> (the problem only occured when CONFIG_PREEMPT was enabled.)

Hello again.

Indeed, no more `scheduling while atomic'.

OTOH, now the system feels terribly slow when voluntary_preemption is set to 2.
Setting it to 0 or 1 makes the sluggish feel go away.

Rudo.
