Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317314AbSGOK7v>; Mon, 15 Jul 2002 06:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSGOK7v>; Mon, 15 Jul 2002 06:59:51 -0400
Received: from holomorphy.com ([66.224.33.161]:23720 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317314AbSGOK7u>;
	Mon, 15 Jul 2002 06:59:50 -0400
Date: Mon, 15 Jul 2002 04:01:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Serial: updated serial drivers
Message-ID: <20020715110135.GI21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20020707010009.C5242@flint.arm.linux.org.uk> <20020715100310.GF23693@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020715100310.GF23693@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 01:00:09AM +0100, Russell King wrote:
>> I've been maintaining a serial driver "off the side" of the ARM port
>> which cleans up the serial driver mess that we currently have, with
>> many duplications of serial.c, each with subtle bugs.

On Mon, Jul 15, 2002 at 03:03:10AM -0700, William Lee Irwin III wrote:
> global_cli() overhead on my testbox is a significant problem.
> Profile info from tbench 1024 with ttyS0 as stdout, taken on a 16 cpu
> i386 box with 16GB of RAM and irqbalance disabled, (needed to boot):

the profiling results were for a kernel without the new serial stuff.
The new serial stuff appears to need some arch compatibility auditing/
fixes for NUMA-Q.



Cheers,
Bill
