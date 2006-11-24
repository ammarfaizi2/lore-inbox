Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935072AbWKXVbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935072AbWKXVbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935074AbWKXVbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:31:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935072AbWKXVbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:31:32 -0500
Date: Fri, 24 Nov 2006 13:30:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Andy Whitcroft <apw@shadowen.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI
 is not defined
Message-Id: <20061124133013.c6435c02.akpm@osdl.org>
In-Reply-To: <200611241833.47671.ak@suse.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<200611241805.45621.ak@suse.de>
	<45672AC8.2010303@shadowen.org>
	<200611241833.47671.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 18:33:47 +0100
Andi Kleen <ak@suse.de> wrote:

> > Can we 
> > guarentee it will be inlined though?  I had the feeling that inline was
> > advisory and if it does not inline then we will get the link failures.
> 
> It's defined to __attribute__((always_inline)) inline

That's an internal implementation detail.  Please use __always_inline
