Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDTIAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDTIAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDTIAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:00:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbWDTIAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:00:31 -0400
Date: Thu, 20 Apr 2006 00:59:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: fix missing string
Message-Id: <20060420005938.6c3d4319.akpm@osdl.org>
In-Reply-To: <1145474021.4894.12.camel@localhost.localdomain>
References: <1145474021.4894.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> A string corresponding to the tcpa_pc_event_id POST_CONTENTS was missing
>  causing an overflow bug when access was attempted in the get_event_name
>  function.

These last two bugs are applicable to 2.6.17.

I'm kind of thinking of pushing all the TPM patches into 2.6.17 actually. 
Although there's quite a lot of feature work in there, we also have
bugfixes, although relatively minor ones.

What's your confidence level in those patches?

Would you have time to do a decent round of regression testing against the
resulting TPM code prior to 2.6.17?  Say, inside the next couple of weeks?
