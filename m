Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVAECT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVAECT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVAECT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:19:58 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:29334 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262200AbVAECTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:19:54 -0500
Message-ID: <41DB4EC7.9070608@yahoo.com.au>
Date: Wed, 05 Jan 2005 13:19:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FRV: Change PML4 -> PUD
References: <18003.1104868971@redhat.com>
In-Reply-To: <18003.1104868971@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patch changes the PML4 bits of the FRV arch to the new PUD way.
> 

Looks OK... any reason you aren't using the asm-generic folding headers?
(asm-generic/pgtable-nopmd.h or asm-generic/pgtable-nopud.h). I sent some
notes to the arch list about getting those working, but apparently it
hasn't come though yet.

Of course I do think it is sensible that you just get it working first,
before getting too fancy.

Nick
