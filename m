Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWEOSYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWEOSYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWEOSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:24:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33499 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965110AbWEOSYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:24:36 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 20:24:31 +0200
User-Agent: KMail/1.9.1
Cc: Andy Whitcroft <apw@shadowen.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <4468C3B8.8090502@shadowen.org> <20060515112456.0624d498.akpm@osdl.org>
In-Reply-To: <20060515112456.0624d498.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152024.31844.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 20:24, Andrew Morton wrote:
> Andy Whitcroft <apw@shadowen.org> wrote:
> >
> > > So it is perhaps reasonable to do this panic, but only if !CONFIG_EMBEDDED? 
> > > (It really is time to start renaming CONFIG_EMBEDDED to CONFIG_DONT_DO_THIS
> > > or something).
> > 
> > How about CONFIG_EXPERIMENTAL?
> 
> Probably CONFIG_ADVANCED would be closer.

Most people who recompile kernels probably think of themselves as advanced.
This doesn't mean they will get these things right.

-Andi
