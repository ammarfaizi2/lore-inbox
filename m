Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTANVbR>; Tue, 14 Jan 2003 16:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTANVbR>; Tue, 14 Jan 2003 16:31:17 -0500
Received: from holomorphy.com ([66.224.33.161]:10120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264910AbTANVbR>;
	Tue, 14 Jan 2003 16:31:17 -0500
Date: Tue, 14 Jan 2003 13:40:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anyone have a 16-bit x86 early_printk?
Message-ID: <20030114214007.GH919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030114113036.GG940@holomorphy.com> <485650000.1042560472@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485650000.1042560472@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I'm trying to get a box to boot and it appears to drop dead before
>> start_kernel(). Would anyone happen to have an early_printk() analogue
>> for 16-bit x86 code?

On Tue, Jan 14, 2003 at 08:07:53AM -0800, Martin J. Bligh wrote:
> See arch/i386/boot/compressed/misc.c - there's a puts() routine in 
> there that should work for most things OK.

Hmm, I wonder why that was never mentioned by some others...

At any rate, it suffices for me.


Bill
