Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbSLSX24>; Thu, 19 Dec 2002 18:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLSX24>; Thu, 19 Dec 2002 18:28:56 -0500
Received: from holomorphy.com ([66.224.33.161]:31427 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267076AbSLSX2z>;
	Thu, 19 Dec 2002 18:28:55 -0500
Date: Thu, 19 Dec 2002 15:36:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.40 64GB highmem BUG()
Message-ID: <20021219233623.GA9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
References: <200210071327.GAA00711@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071327.GAA00711@adam.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 06:27:19AM -0700, Adam J. Richter wrote:
> 	Although 2.5.40 has been out for a while, I think I ought
> to post this bug as I haven't seen any other mention of it.
> 	When I boot an 2.5.40 x86 kernel built with CONFIG_HIGHMEM64G,
> and with a 920kB initial ramdisk (2.2MB uncompressed), I get a kernel
> BUG() at highmem.c line 480, preceded by a message saying "scheduling
> with KM_TYPE 15 held!"  The machine on which I experienced this
> problem has 1.25GB of RAM.  The problem occurs with and without
> CONFIG_PREEMPT.  All kernels that tried were SMP kernels running on a
> uniprocessor.

This is not reproducible here with 2.5.52-mm2. Is the initrd required
to trigger this?


Thanks,
Bill
