Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVCXVxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVCXVxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVCXVxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:53:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:29827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261583AbVCXVxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:53:30 -0500
Date: Thu, 24 Mar 2005 13:53:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2 (patch to fix build error In function
 `zft_init')
Message-Id: <20050324135308.526f1a3e.akpm@osdl.org>
In-Reply-To: <20050324214958.GA26919@kroah.com>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<4242D820.8070801@mesatop.com>
	<4242E2E1.2060402@mesatop.com>
	<20050324214958.GA26919@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
>  > I glanced at the code, and this little patch fixes the problem:
> 
>  Ick, sorry, that was my fault.  I've applied this patch to my trees,
>  thanks.
> 
>  Hm, I wonder how I missed this, I did do a 'make allmodconfig' build to
>  try to catch this kind of stuff...

allmodconfig doesn't catch BROKEN_ON_SMP code.  I've been caught out by
that a few times.

