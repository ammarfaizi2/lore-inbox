Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVCQSfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVCQSfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVCQSfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:35:50 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:21691 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262391AbVCQSff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:35:35 -0500
Subject: Re: Kernel memory limits?
From: Dave Hansen <haveblue@us.ibm.com>
To: "Peter W. Morreale" <peter_w_morreale@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
References: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 10:34:48 -0800
Message-Id: <1111084488.4945.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 11:06 -0700, Peter W. Morreale wrote:
> (I did not see this addressed in the FAQs...)
> 
> How much physical memory can the 2.4.26 kernel address in kernel context on 
> x86?

896 MB

There are patches to move this around, though.

> What about DMA memory?

What kind of DMA?

> Local rumor says ~1GB.  But this makes little sense given a 32-bit address.
> 
> Where in the source can I learn more about this?

arch/i386
include/asm-i386 

:)

Check out MAXMEM in include/asm-i386/page.h (at least 2.6)

-- Dave

