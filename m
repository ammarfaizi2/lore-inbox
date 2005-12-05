Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVLEAku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLEAku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 19:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVLEAku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 19:40:50 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:41702 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932352AbVLEAkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 19:40:49 -0500
Subject: Re: 2.6.14-rt21 & evolution
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: dino@in.ibm.com
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204145823.GA5756@in.ibm.com>
References: <1133642866.16477.11.camel@cmn3.stanford.edu>
	 <1133647737.5890.2.camel@mindpipe>
	 <1133653696.16477.47.camel@cmn3.stanford.edu>
	 <20051204145823.GA5756@in.ibm.com>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 16:40:21 -0800
Message-Id: <1133743221.20894.3.camel@cmn34.stanford.edu>
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

I'll definitely try this and report back. Thanks!

I just double checked, and had no trouble starting evolution with a
previous kernel on a different machine (after several days of having the
same problem running on -rt21). 

-- Fernando


