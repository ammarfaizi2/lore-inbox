Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWFMUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWFMUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFMUK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:10:59 -0400
Received: from fmr18.intel.com ([134.134.136.17]:34760 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932188AbWFMUK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:10:58 -0400
Message-ID: <448F1B97.3070207@linux.intel.com>
Date: Tue, 13 Jun 2006 13:09:59 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] i386 syscall opcode reordering (pipelining)
References: <20060613195446.GD24167@rhlx01.fht-esslingen.de>
In-Reply-To: <20060613195446.GD24167@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi all,
> 
> I'd guess that this version features improved pipeline parallelism,
> since we isolate competing %ebx accesses (_syscall4()) and
> stack push operations (_syscall5()), right?

is anybody actually EVER using those???
I would think not....
