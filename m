Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265726AbUF2LMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbUF2LMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUF2LMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:12:15 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:41939 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265719AbUF2LMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:12:08 -0400
Date: Tue, 29 Jun 2004 04:11:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG FIX] [PATCH] fork_init() max_low_pfn fixes potential OOM bug on big highmem machine
Message-ID: <20040629111155.GB25061@taniwha.stupidest.org>
References: <40E03F71.8010902@greatcn.org> <20040628175325.B9214@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628175325.B9214@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 05:53:25PM +0100, Russell King wrote:

> This is wrong - max_low_pfn can be high on systems where physical
> RAM doesn't start at address 0.

FWIW sn2 also doesn't have memory at 0 either.


  --cw
