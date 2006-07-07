Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWGGKYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWGGKYz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGGKYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:24:55 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:39886 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932120AbWGGKYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:24:54 -0400
Date: Fri, 7 Jul 2006 06:21:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: require ACPI for NUMA with generic
  architecture
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607070623_MC3-1-C45A-2428@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <a762e240607061143s6470ad5y310986cba4f0b0bc@mail.gmail.com>

On Thu, 6 Jul 2006 11:43:37 -0700, Keith Mannthey wrote:

> On 7/6/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > X86 Generic Architecture (X86_GENERICARCH) includes support for
> > Summit architecture.  Enabling X86_GENERICARCH, SMP and HIGHMEM64G
> > allows NUMA to be selected but that configuration will not build
> > because it requires ACPI for the Summit NUMA support.
> 
> Good catch.    With X86_GENRICARCARCH perhaps NUMA should always be on
> or am I missing something with how it is supposed to work?  Shouldn't
> X86_GENRICARCARCH buy you the ablility to boot(correctly) on all the
> diffrent archs listed?

AFAIK not all Summit machines are NUMA, so maybe the flexibility is
needed.  e.g. some might want GENERICARCH without HIGHMEM64G.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
