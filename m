Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVA0RkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVA0RkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVA0Rjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:39:37 -0500
Received: from embeddededge.com ([209.113.146.155]:31757 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S262006AbVA0RhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:37:24 -0500
In-Reply-To: <20050127171555.GA3999@elf.ucw.cz>
References: <39DB0285-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com> <20050127171555.GA3999@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FFF9B138-7089-11D9-AE1E-003065F9B7DC@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] add AMD Geode processor support
Date: Thu, 27 Jan 2005 09:36:39 -0800
To: Pavel Machek <pavel@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 27, 2005, at 9:15 AM, Pavel Machek wrote:

> We do not disable HIGHMEM_64GB for 486, I do not see why we should add
> extra code to geode...

What about some of the other ones like MTRR and IOAPIC?
I was kinda passing this along from someone I thought knew
better than I, but I didn't like it either.  It seems just setting these
booleans to 'n' should do the trick.

Thanks.	

	-- Dan

