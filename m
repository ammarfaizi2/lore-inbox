Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316016AbSEJPLT>; Fri, 10 May 2002 11:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316017AbSEJPLS>; Fri, 10 May 2002 11:11:18 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:58538 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316016AbSEJPLR>; Fri, 10 May 2002 11:11:17 -0400
Date: Fri, 10 May 2002 08:11:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Patricia Gaughen <gone@us.ibm.com>
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8
Message-ID: <364669737.1021018260@[10.10.2.3]>
In-Reply-To: <20020510092436.A7038@infradead.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This looks much better.  The only question that came up to me now that
> the CONFIG_ stuff is cleaned up a lot: What is the difference between
> CONFIG_X86_NUMAQ and CONFIG_MULTIQUAD?

The former is for NUMAQ specific stuff, the latter was intended to
switch on clustered apic mode support, which could be used by other
machines too. Due a lack of differentiation in the past, we probably
use CONFIG_MULTIQUAD (or rather its child, clustered_apic_mode) 
in a few places where we should be using CONFIG_X86_NUMAQ. My
laziness - sorry ;-)

M.

