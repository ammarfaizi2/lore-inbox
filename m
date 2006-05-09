Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWEIO2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWEIO2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWEIO2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:28:53 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:44220 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750858AbWEIO2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:28:53 -0400
Date: Tue, 9 May 2006 10:28:51 -0400
To: Carlos Ojea Castro <nuudoo.fb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LPC bus in a geode sc1200
Message-ID: <20060509142851.GA2837@csclub.uwaterloo.ca>
References: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:11:17AM +0200, Carlos Ojea Castro wrote:
> I wrote a driver to use LPC bus in a geode sc1200. For now I am able
> to transmit an read or write "I/O cycle" to the LPC.
> What I want to do now is to read or write to the LPC using a "Memory cycle".
> 
> Anyone knows how can I archieve this?
> is there another list more suitable for my question?

The LPC bus is the same as ISA as far as software is concerned.  You
just read and write to it, or do DMA or whatever you want.

I have an FPGA on port 0x500 on the LPC bus of an sc1200, and I just
read and write the registers there the same as any other hardware.

Len Sorensen
