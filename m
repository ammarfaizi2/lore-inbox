Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbTGCXEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265582AbTGCXEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:04:41 -0400
Received: from holomorphy.com ([66.224.33.161]:33476 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265465AbTGCXCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:02:07 -0400
Date: Thu, 3 Jul 2003 16:16:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030703231623.GU26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Boszormenyi Zoltan <zboszor@freemail.hu>,
	linux-kernel@vger.kernel.org
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703122243.51a6d581.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>> I actually tried it. It seems that although I compiled an SMP kernel, it 
>> does not use both CPUs.

On Thu, Jul 03, 2003 at 12:22:43PM -0700, Andrew Morton wrote:
> You're right.  The kernel sort-of saw the second CPU but it appears to have
> not come up.
> Have you used any other 2.5 kernels?  Are you able to pinpoint and
> particular kernel version at which this started to happen?
> If not then I'd appreciate it if you could test stock 2.4.74.

Boszormenyi, can you try with APIC_DEBUG defined to 1 in
include/asm-i386/acpidef.h and reproduce with ACPI off in your .config?


-- wli
