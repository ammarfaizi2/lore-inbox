Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266994AbUBFAFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266948AbUBFAFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:05:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9138 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266354AbUBFAFH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:05:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Daniel McNeil <daniel@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat" DIO read race still fails
Date: Thu, 5 Feb 2004 15:58:08 -0800
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
References: <20040205014405.5a2cf529.akpm@osdl.org> <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
In-Reply-To: <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402051558.08927.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 February 2004 03:31 pm, Daniel McNeil wrote:
> Andrew,
>
> I tested 2.6.2-mm1 on an 8-proc running 6 copies of the read_under
> test and all 6 read_under tests saw uninitialized data in less than 5
> minutes. :(
>
> Daniel

Daniel,

Same here... Just FYI, I am running with your original patch and
not failed so far (2 hours..) Normally, I see the problem in 15 min or so.

Thanks,
Badari
