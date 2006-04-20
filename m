Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWDTOLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDTOLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDTOLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:11:25 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:62932 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750748AbWDTOLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:11:24 -0400
Subject: Re: [PATCH] tpm: fix missing string
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060420005938.6c3d4319.akpm@osdl.org>
References: <1145474021.4894.12.camel@localhost.localdomain>
	 <20060420005938.6c3d4319.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 09:07:22 -0500
Message-Id: <1145542042.4894.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 00:59 -0700, Andrew Morton wrote:
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> >
> > A string corresponding to the tcpa_pc_event_id POST_CONTENTS was missing
> >  causing an overflow bug when access was attempted in the get_event_name
> >  function.
> 
> These last two bugs are applicable to 2.6.17.
Correct.
> 
> I'm kind of thinking of pushing all the TPM patches into 2.6.17 actually. 
> Although there's quite a lot of feature work in there, we also have
> bugfixes, although relatively minor ones.
> 
> What's your confidence level in those patches?

> Would you have time to do a decent round of regression testing against the
> resulting TPM code prior to 2.6.17?  Say, inside the next couple of weeks?

I'm pretty confident.  Yesterday's bug fixes were the last things I know
of that needed attention.  I'd be happy to run regression testing in the
next couple of weeks.

Thanks,
Kylie

