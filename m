Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265146AbUF1Tbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUF1Tbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUF1T2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:28:17 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:43333 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265151AbUF1T1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:27:22 -0400
Message-ID: <8783be6604062812277ee07aa@mail.gmail.com>
Date: Mon, 28 Jun 2004 12:27:22 -0700
From: Ross Biro <ross.biro@gmail.com>
To: Matt Sexton <sexton@mc.com>
Subject: Re: DRAM and PCI devices at same physical address
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1088198580.29697.62.camel@dhcp_client-120-140>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1088198580.29697.62.camel@dhcp_client-120-140>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jun 2004 17:23:00 -0400, Matt Sexton <sexton@mc.com> wrote:

> 
> Should they be appearing there at all?  Does Linux make any guarantees
> when there is more physical memory than specified by "mem=" ?

You've told linux there is only 512M of physical memory and it
believes you, so it is using the available address space for memory
mapped i/o.  I know of no way to reserve memory on the command line.
