Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVCAWDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVCAWDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVCAWDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:03:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:13794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbVCAWDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:03:35 -0500
Date: Tue, 1 Mar 2005 14:08:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, ralf@linux-mips.org,
       schwidefsky@de.ibm.com
Subject: Re: 2.6.11-rc5-mm1
Message-Id: <20050301140836.2d3aa0a3.akpm@osdl.org>
In-Reply-To: <20050301214916.GJ28536@shell0.pdx.osdl.net>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<20050301214916.GJ28536@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > - I seem to be getting a lot of patches which don't compile if you breathe
> >   on the .config file, let alone if you try them on another architecture.  It
> >   would be nice to receive less such patches, please.
> 
> The ia64 audit bit is likely my fault from the audit header detangle.

I figured something like that, but the change is a good one anwyay.  IOW:
your cleanup exposed a prior problem...

