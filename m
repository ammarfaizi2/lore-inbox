Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUD3Xni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUD3Xni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUD3Xni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 19:43:38 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:33470 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261865AbUD3Xne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 19:43:34 -0400
Date: Sat, 1 May 2004 01:43:33 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jeff Dike <jdike@addtoit.com>
Cc: Shailabh <nagar@watson.ibm.com>, Rik van Riel <riel@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
Message-ID: <20040430234332.GA10569@MAIL.13thfloor.at>
Mail-Followup-To: Jeff Dike <jdike@addtoit.com>,
	Shailabh <nagar@watson.ibm.com>, Rik van Riel <riel@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ckrm-tech <ckrm-tech@lists.sourceforge.net>
References: <20040430174117.A13372@infradead.org> <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com> <4092AD60.1030809@watson.ibm.com> <200404302217.i3UMHdml004610@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404302217.i3UMHdml004610@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 06:17:39PM -0400, Jeff Dike wrote:
> nagar@watson.ibm.com said:
> > Jeff, do you have any numbers for UML overhead in 2.6 ? 
> 
> It obviously depends on the workload, but for "normal" things, like kernel
> builds and web serving, it's generally in the 20-30% range.  That can be 
> reduced, since I haven't spent too much time on tuning.  I'm aiming for the
> teens, and I don't think that'll be too hard.

hmm, just wanted to mention that linux-vserver has
around 0% overhead and often allows to improve 
performance due to resource sharing ... 

basically it's a soft partitioning concept based on 
'Security Contexts' which allow to create many 
independant Virtual Private Servers (VPS), which
act simultaneously on one box at full speed, sharing
the available hardware resources.

see http://linux-vserver.org for details ...

best,
Herbert

PS: UML and Linux-VServer play together nicely ...

> 
> 				Jeff
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE. 
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
