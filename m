Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTANNeM>; Tue, 14 Jan 2003 08:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTANNeM>; Tue, 14 Jan 2003 08:34:12 -0500
Received: from holomorphy.com ([66.224.33.161]:11654 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263333AbTANNeL>;
	Tue, 14 Jan 2003 08:34:11 -0500
Date: Tue, 14 Jan 2003 05:43:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anyone have a 16-bit x86 early_printk?
Message-ID: <20030114134301.GF919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Gerst <bgerst@quark.didntduck.org>,
	linux-kernel@vger.kernel.org
References: <20030114113036.GG940@holomorphy.com> <3E240CEB.8070301@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E240CEB.8070301@quark.didntduck.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I'm trying to get a box to boot and it appears to drop dead before
>> start_kernel(). Would anyone happen to have an early_printk() analogue
>> for 16-bit x86 code?

On Tue, Jan 14, 2003 at 08:13:15AM -0500, Brian Gerst wrote:
> It could be failing in the decompression routine if it was compiled for 
> the wrong cpu (ie. using cmov instructions).

The cpu has cmov. It's Pentium-III. It suceeds in one configuration of
the machine and fails in another.


Bill
