Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHVQDd>; Thu, 22 Aug 2002 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSHVQDd>; Thu, 22 Aug 2002 12:03:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53495 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313305AbSHVQDb>;
	Thu, 22 Aug 2002 12:03:31 -0400
Date: Thu, 22 Aug 2002 09:06:20 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
Message-ID: <2631076918.1030007179@[10.10.2.3]>
In-Reply-To: <1030031958.14756.479.camel@spc9.esa.lanl.gov>
References: <1030031958.14756.479.camel@spc9.esa.lanl.gov>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kjournald: page allocation failure. order:0, mode:0x0

I've seen this before, but am curious how we ever passed
a gfpmask (aka mode) of 0 to __alloc_pages? Can't see anywhere
that does this?

Thanks,

M.

