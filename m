Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUAWG0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbUAWG0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:26:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:2262 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265369AbUAWG0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:26:30 -0500
Date: Thu, 22 Jan 2004 22:27:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about terminology.
Message-Id: <20040122222720.19e905f9.akpm@osdl.org>
In-Reply-To: <1074799304.12771.93.camel@laptop-linux>
References: <1074799304.12771.93.camel@laptop-linux>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
>
> Hi again.
> 
> When I began work on swapfile support, I looked for an efficient method
> to store all the information on which blocks were used. The process led
> me to develop something I called ranges, which Pavel later looked at and
> said something like 'Oh. Extents.'
> 
> Throughout the code, I still call them ranges (I have, for example
> struct range and struct rangechain). In preparation for merging, should
> I go through an rename ranges to extents, or will they be okay as it is?

Are you aware of the current `struct swap_extent' and its supporting
infrastructure?

