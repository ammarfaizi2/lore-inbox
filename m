Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbTIQAsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbTIQAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:48:55 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:19076 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262551AbTIQAsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:48:54 -0400
Date: Tue, 16 Sep 2003 17:48:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ben Johnson <ben@blarg.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel addrs?
Message-ID: <1562370000.1063759683@[10.10.2.4]>
In-Reply-To: <20030916154747.A22526@blarg.net>
References: <20030916154747.A22526@blarg.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) When I am referencing a pointer in the kernel, is the value of that
> pointer variable interpreted by the cpu as a logical or linear address?
> 
> 2) if I have two overlapping data/stack segments presently selected,
> each with a different base, how does the cpu know which segment/base
> address to use to get the linear address?

IIRC, all the base segments are 0, so none of this matters ;-)

M.

