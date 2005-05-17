Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVEQNjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVEQNjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVEQNjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:39:52 -0400
Received: from fisica.ufpr.br ([200.17.209.129]:3539 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S261184AbVEQNjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:39:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <17033.62480.218289.246488@fisica.ufpr.br>
Date: Tue, 17 May 2005 10:39:28 -0300
To: Con Kolivas <kernel@kolivas.org>
Cc: AndrewMorton <akpm@osdl.org>, ck@vds.kolivas.org,
       Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [SMP NICE] [PATCH] SCHED: Implement nice support across physical cpus on SMP
In-Reply-To: <200505162133.13399.kernel@kolivas.org>
References: <20050509112446.GZ1399@nysv.org>
	<17023.63512.319555.552924@fisica.ufpr.br>
	<200505111304.06853.kernel@kolivas.org>
	<200505162133.13399.kernel@kolivas.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas (kernel@kolivas.org) wrote on 16 May 2005 21:33:
 >On Wed, 11 May 2005 13:04, Con Kolivas wrote:
 >> Andrew please consider for inclusion in -mm
 >
 >It looks like I missed my window of opportunity and the SMP balancing design 
 >has been restructured in latest -mm again so this patch will have to wait 
 >another generation. Carlos, Markus you'll have to wait till that code settles 
 >down (if ever) before I (or someone else) rewrites it for it to get included 
 >in -mm followed by mainline. The patch you currently have will work fine for 
 >2.6.11* and 2.6.12*

That's a pity. What's more important however is that this misfeature
of the scheduler should be corrected ASAP. The nice control is a
traditional UNIX characteristic and it should have higher priority in
the patch inclusion queue than other scheduler improvements.
