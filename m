Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161522AbWHEGgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161522AbWHEGgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 02:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbWHEGgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 02:36:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:733 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161522AbWHEGgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 02:36:00 -0400
Date: Fri, 4 Aug 2006 23:35:40 -0700
From: Greg KH <greg@kroah.com>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI and SKIP bit
Message-ID: <20060805063540.GA25389@kroah.com>
References: <m3irlbibsp.fsf@lx-ltd.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3irlbibsp.fsf@lx-ltd.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 04:04:22PM +0400, Sergej Pupykin wrote:
> 
> Hi, All!
> 
> According to ohci spec (4.2.1, page 16) K (skip) bit is 12th.

The OHCI USB or IEEE1394 spec?

> But in both (2.4 and 2.6) kernels I see
> 
> #define OHCI_ED_SKIP    (1 << 14)
> 
> Please advise.

Why not ask this on the specific subsystem developer mailing list?  Is
this not working properly for you on your hardware?

thanks,

greg k-h
