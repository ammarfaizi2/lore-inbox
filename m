Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269191AbUJMPcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbUJMPcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 11:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJMPcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 11:32:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37059 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269146AbUJMPb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 11:31:57 -0400
Subject: Re: Using ilookup?
From: Lee Revell <rlrevell@joe-job.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: manningc2@actrix.gen.nz, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097657423.5178.42.camel@localhost.localdomain>
References: <20041013013930.9BB6649E9@blood.actrix.co.nz>
	 <1097657423.5178.42.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1097680972.5879.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 11:22:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 04:50, David Woodhouse wrote:
> > 2') A further issue here is that ilookup is not available in some older 2.4.x 
> > versions. Is it Ok to just patch the ilookup code in, say, 2.4.27 back into 
> > earlier versions (say 2.4.18 which seems a popular vintage for embedded stuff 
> > for some reason or other).
> 
> No. If these people want new file systems and new features in code code,
> why on earth are they still using 2.4.18? They should be on 2.6, or at
> _least_ current 2.4 kernels. I could sort of understand if they've had a
> lot of testing in the two and a half years since 2.4.18 was released and
> they don't want to change _anything_.... but that obviously isn't the
> case if they're adding new stuff like this.

2.4.18 is probably popular for embedded applications because that's
about where development on the preempt/low latency patches for 2.4
stopped.

Lee 

