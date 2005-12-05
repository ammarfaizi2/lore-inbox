Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVLERic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVLERic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLERic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:38:32 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:15080 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932480AbVLERib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:38:31 -0500
Subject: Re: 2.6.14-rt21 & evolution
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: dino@in.ibm.com
Cc: nando@ccrma.Stanford.EDU, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204145823.GA5756@in.ibm.com>
References: <1133642866.16477.11.camel@cmn3.stanford.edu>
	 <1133647737.5890.2.camel@mindpipe>
	 <1133653696.16477.47.camel@cmn3.stanford.edu>
	 <20051204145823.GA5756@in.ibm.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 09:38:14 -0800
Message-Id: <1133804294.4752.1.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 20:28 +0530, Dinakar Guniguntala wrote:
> On Sat, Dec 03, 2005 at 03:48:16PM -0800, Fernando Lopez-Lezcano wrote:
> > 
> > To tell the truth this does not seem like a -rt related problem except
> > that it started happening the day I booted into -rt21. 
> > 
> 
> Can you try this patch below. Ingo has already included it in his tree
> and will probably show up in -rt22.
> 
> This was changed in -rt14 and returns spurious -ETIMEDOUT from
> FUTEX_WAIT calls which I just checked that evo does a lot of

Good news. I tried it and seems to be working. Not conclusive as this
was just one evolution startup in the morning but there were no crashes
(and I was consistently getting them with plain -rt21). 

Woohoo!
Thanks!
-- Fernando


